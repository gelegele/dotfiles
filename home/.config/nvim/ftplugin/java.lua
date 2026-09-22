-- nvim-jdtls: started on each FileType=java (see :help jdtls)
-- Scheduled so lazy.nvim can finish loading the plugin first.
if vim.g.vscode ~= nil or vim.fn.has('win64') == 1 then
  return
end

local bufnr = vim.api.nvim_get_current_buf()

vim.schedule(function()
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local ok, jdtls = pcall(require, 'jdtls')
  if not ok then
    return
  end

  local jdtls_bin = vim.fn.exepath('jdtls')
  if jdtls_bin == '' then
    local mason_bin = vim.fn.stdpath('data') .. '/mason/bin/jdtls'
    if vim.fn.executable(mason_bin) == 1 then
      jdtls_bin = mason_bin
    else
      vim.notify('jdtls not found. Install via :MasonInstall jdtls', vim.log.levels.WARN)
      return
    end
  end

  local root_dir = vim.fs.root(bufnr, {
    'gradlew', 'mvnw', 'pom.xml', 'build.gradle', 'build.gradle.kts', '.git',
  })
  if not root_dir then
    return
  end

  local project_name = vim.fs.basename(root_dir)
  local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls-workspace/' .. project_name

  local cmd = {
    jdtls_bin,
    '-data', workspace_dir,
    '--jvm-arg=-Djava.import.generatesMetadataFilesAtProjectRoot=false',
  }

  -- Lombok: Mason ships lombok.jar with jdtls; javaagent is required for getters/setters etc.
  local lombok_jar = vim.fn.stdpath('data') .. '/mason/packages/jdtls/lombok.jar'
  if vim.fn.filereadable(lombok_jar) == 1 then
    table.insert(cmd, '--jvm-arg=-javaagent:' .. lombok_jar)
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  if has_cmp then
    capabilities = cmp_lsp.default_capabilities(capabilities)
  end

  local extendedClientCapabilities = jdtls.extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  local config = {
    name = 'jdtls',
    cmd = cmd,
    root_dir = root_dir,
    settings = {
      java = {
        eclipse = { downloadSources = true },
        configuration = {
          updateBuildConfiguration = 'interactive',
        },
        maven = { downloadSources = true },
        references = { includeDecompiledSources = true },
        jdt = {
          ls = {
            lombokSupport = { enabled = true },
          },
        },
      },
    },
    capabilities = capabilities,
    init_options = {
      bundles = {},
      extendedClientCapabilities = extendedClientCapabilities,
    },
    on_attach = function(_, b)
      local opts = { silent = true, buffer = b }
      vim.keymap.set('n', '<A-o>', function() jdtls.organize_imports() end, opts)
      vim.keymap.set('n', 'crv', function() jdtls.extract_variable() end, opts)
      vim.keymap.set('x', 'crv', "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", opts)
      vim.keymap.set('n', 'crc', function() jdtls.extract_constant() end, opts)
      vim.keymap.set('x', 'crc', "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", opts)
      vim.keymap.set('x', 'crm', "<esc><cmd>lua require('jdtls').extract_method(true)<cr>", opts)
    end,
  }

  jdtls.start_or_attach(config)
end)
