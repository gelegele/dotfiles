--[[
My init.lua for NEOVIM

This file path is
Linux: ~/.config/nvim/init.lua
Windows: %LOCALAPPDATA%\nvim\init.lua

How to check health is [:checkhealth]:
]]--

-- Leader key is space.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- I don't need swap files.
vim.opt.swapfile = false
-- tab space is 2.
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- Show line numbers.
vim.opt.number = true
-- Show tail spaces.
vim.opt.list = true
-- High Light Search
vim.opt.hlsearch = true
-- ignore case
vim.opt.ignorecase = true
-- case-sensitive if capital letters
vim.opt.smartcase = true
-- auto wrap
vim.opt.wrap = true
-- show cursor horizontal line
vim.opt.cursorline = true
-- show cursor vertical line
vim.opt.cursorcolumn = true
-- Allow keys below that move the cursor to move to the pre/next line.
vim.opt.whichwrap = "b,[,],<,>"
-- enable clipboard sync.
if vim.fn.has("wsl") == 1 then
  -- Suppress clipboard.vim loading delay at startup if wsl.
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    -- Below is too heavy to load registers. You should use terminal function to paste clipboard.
    -- paste = {
    --   ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", "")',
    --   ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    -- },
    cache_enabled = 0,
  }
end
vim.opt.clipboard = 'unnamedplus'

-- pseudo-transparency for a floating window and the popup menu.
vim.opt.winblend = 10
vim.opt.pumblend = 10
-- True Color
vim.opt.termguicolors = true
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Ctrl + s to :w
vim.keymap.set('n', '<Leader><CR>', ':w<CR>')
-- Space + q to :q
vim.keymap.set('n', '<C-q>', ':q<CR>')
-- !! to :q!
vim.keymap.set('n', '!!', ':qa!<CR>')
-- Space + p to put clipboard text
-- vim.keymap.set('n', '<Leader>p', '"*p')
-- vim.keymap.set('n', '<Leader>P', '"*P')
-- Change buffer
vim.keymap.set('n', '<Leader>]', ':bn<CR>')
vim.keymap.set('n', '<Leader>[', ':bp<CR>')
-- Delete buffer
vim.keymap.set('n', '<Leader>x', ':bd|bn<CR>')
-- jj to go to NORMAL mode
vim.keymap.set('i', 'jj', '<ESC>')
-- Enter to insert a blank line in normal-mode.
-- * C-CR = C-j and S-CR = CR on Windows Terminal. I gave up mapping these keys.
vim.keymap.set('n', '<CR>', 'o<ESC>')
-- j, k replace gj, gk not to slip wrap lines.
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
-- J to join lines without space.
vim.keymap.set('n', 'J', 'gJ')
vim.keymap.set('n', 'gg', 'ggzz')
-- Keep the cursor while moving search words 
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
-- Don't move the cursor when starting a word search.
vim.keymap.set('n', '*', '*N')
vim.keymap.set('n', '#', '#N')
-- ESC to clear search highlight.
vim.keymap.set('n', '<ESC><ESC>', ':nohl<CR><C-l>')
-- window resize enhanced
vim.keymap.set('n', '<C-w>+', ':resize +3<CR>')
vim.keymap.set('n', '<C-w>-', ':resize -3<CR>')
vim.keymap.set('n', '<C-w>>', ':vertical resize +5<CR>')
vim.keymap.set('n', '<C-w><', ':vertical resize -5<CR>')
-- Space + n to toggle line numbers.
vim.keymap.set('n', '<Leader>n', ':set nonumber!<CR>')
-- Space + n to toggle auto wrap.
vim.keymap.set('n', '<Leader>w', ':set wrap!<CR>')
-- Space + e to open the tree.
vim.keymap.set('n', '<Leader>e', ':NvimTreeToggle<CR>')

-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git', '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  { -- Install NERD FONT on your OS.
    'nvim-tree/nvim-web-devicons',
  },
  { -- Check startup time
    'dstein64/vim-startuptime'
  },
  { -- Dashboard
    'glepnir/dashboard-nvim',
    config = function()
      require('dashboard').setup {
        config ={
          header = {
            [[ ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗ ]],
            [[ ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║ ]],
            [[ ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║ ]],
            [[ ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║ ]],
            [[ ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║ ]],
            [[ ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝ ]],
            [[                                                        ]],
          },
          shortcut = {
            { desc = ' New',        group = 'Label', action = 'enew',                             key = 'n' },
            { desc = ' Tree',       group = 'Label', action = 'e .',                              key = '.' },
            { desc = ' Config',     group = 'Label', action = 'e ~/.config/nvim/init.lua',        key = 'c' },
            { desc = ' Lazy',       group = 'Label', action = 'Lazy',                             key = 'l' },
            { desc = ' Files',      group = 'Label', action = 'Telescope find_files hidden=true', key = 'f' },
            { desc = ' StartupTime',group = 'Label', action = 'StartupTime',                      key = 's' },
          },
          packages = { enable  = false },
          project = { enable  = false },
          mru = { limit = 8, key = '', },
          footer = { '', 'This is your life.', 'Be yourself.' },
        }
      }
    end,
  },
  { -- fuzzy finder
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          hidden = true,
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<C-h>"] = "which_key"
            }
          },
        },
      }
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>tf', builtin.find_files, { desc = 'find files' })
      vim.keymap.set('n', '<leader>tg', builtin.live_grep, { desc = 'live grep' })
      vim.keymap.set('n', '<leader>tb', builtin.buffers, { desc = 'buffers' })
      vim.keymap.set('n', '<leader>tr', builtin.registers, { desc = 'registers. But you can use which-key.' })
      vim.keymap.set('n', '<leader>ts', builtin.git_status, { desc = 'git status' })
      vim.keymap.set('n', '<leader>th', builtin.help_tags, { desc = 'help tags' })
    end
  },
  { -- Filer (Help: ?)
    'nvim-tree/nvim-tree.lua',
    config = function()
      -- If buffer is a dir, change to the dir and open the tree.
      local function open_nvim_tree(data)
        if vim.fn.isdirectory(data.file) == 1 then
          vim.cmd.cd(data.file)
          require("nvim-tree.api").tree.open()
        end
      end
      vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
      -- My keymaps
      local api = require("nvim-tree.api")
      local function opts(bufnr, desc)
        return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      require("nvim-tree").setup({
        on_attach = function(bufnr)
          api.config.mappings.default_on_attach(bufnr)
          vim.keymap.set('n', '?', api.tree.toggle_help,           opts(bufnr, 'Help'))
          vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts(bufnr, 'Close Directory'))
          vim.keymap.set('n', 'l', api.node.open.edit,             opts(bufnr, 'Open Edit'))
          vim.keymap.set('n', '<Leader>e', api.tree.toggle,        opts(bufnr, 'Toggle Tree'))
        end,
      })
    end
  },
  { 'jacoborus/tender.vim', },
  { 'joshdick/onedark.vim', },
  { 'sainnhe/sonokai', },
  { 'Mofiqul/vscode.nvim',
    priority = 1000,
    config = function()
      -- Prevent error on VS Code
      if not vim.g.vscode then
        vim.cmd.colorscheme 'vscode'
      end
    end,
  },
  { -- show buffer tabs
    'akinsho/bufferline.nvim',
    event = 'BufRead',
    config = function()
      require('bufferline').setup{
        options = {
          right_mouse_command = nil, -- default was bdelete!
          offsets = {{
              filetype = 'NvimTree',
              separator = true,
          }},
        }
      }
    end,
  },
  { -- Status Line
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = '',
        -- section_separators = '',
        path = 2, -- 0:filename, 1:relative, 2:absolute
        disabled_filetypes = {'NvimTree'}, -- Hide in nvim-tree
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      if vim.fn.has('win64') == 1 then
        -- Disabled to prevent errors on Windows.
        return
      end
      require'nvim-treesitter.configs'.setup {
        auto_install = true,
        highlight = { enable = true, },
        indent = { enable = true, },
      }
    end
  },
  { -- Show indents
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
  },
  {
    'williamboman/mason.nvim',
    config = function()
      if vim.fn.has('win64') == 1 then
        -- No LSP on Windows
        return
      end
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      if vim.fn.has('win64') == 1 then
        -- No LSP on Windows
        return
      end
      require('mason-lspconfig').setup {}
      require("mason-lspconfig").setup_handlers {
        function (server_name) -- default handler (optional)
          local opts = {}
          opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
          opts.settings = {
            Lua = {
              diagnostics = { globals = { 'vim' } }
            }
	        }
          require("lspconfig")[server_name].setup(opts)
        end,
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          -- { name = "buffer" },
          -- { name = "path" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ['<C-l>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
        }),
        experimental = {
          ghost_text = true,
        },
      })
    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  { -- Show shortcut keys
    'folke/which-key.nvim',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({})
    end,
  },
  { -- Scroll Bar
    'petertriho/nvim-scrollbar',
    event = 'BufRead',
    config = function()
      require('scrollbar').setup({
        handlers = {
          -- cursor = false,  -- Hide cursor mark on bar
          gitsigns = true, -- Requires gitsigns
        },
      })
    end
  },
  { -- Show git status
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = function()
      require('gitsigns').setup({
        signcolumn = false,
        numhl      = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- keymaps
          map('n', '<leader>g]',
            function()
              if vim.wo.diff then return ']c' end
              vim.schedule(function() gs.next_hunk() end)
              return '<Ignore>'
            end,
            { desc='next hunk', expr=true})
          map('n', '<leader>g[',
            function()
              if vim.wo.diff then return '[c' end
              vim.schedule(function() gs.prev_hunk() end)
              return '<Ignore>'
            end,
            { desc='prev hunk', expr=true})
          map({'n', 'v'}, '<leader>gu', ':Gitsigns stage_hunk<CR>', { desc = 'stage hunk' })
          map({'n', 'v'}, '<leader>g!', ':Gitsigns reset_hunk<CR>', { desc = 'reset hunk' })
          map('n', '<leader>gU', gs.stage_buffer, { desc = 'stage buffer' })
          map('n', '<leader>gd', function() gs.diffthis('~') end, { desc = 'diff HEAD' })
        end
      })
    end
  },
  {
    'sindrets/diffview.nvim',
    dependencies = {'nvim-lua/plenary.nvim'},
    event = 'BufRead',
  },
  { -- Seamless window selection with tmux
    'christoomey/vim-tmux-navigator',
  },
  { -- Preview markdown with nodejs
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.keymap.set('n', '<leader>m', '<Plug>MarkdownPreviewToggle', { desc = 'MarkdownPreviewToggle' })
    end,
  },
  { -- vwS' to quote the v-mode selected word.
    -- cs'" to change single quotation to double quotation.
    'kylechui/nvim-surround',
    event = 'BufRead',
    config = function()
      require('nvim-surround').setup()
    end
  },
  { -- gcc to comment in/out
    'tpope/vim-commentary',
    event = 'BufRead',
  },
  { -- Space + t to toggle boolean
    'gerazov/toggle-bool.nvim',
    event = 'BufRead',
    config = function()
      require('toggle-bool').setup({
        mapping = "<leader>b",
      })
    end,
  },
  { -- Automatically close brackets
    'jiangmiao/auto-pairs',
    event = 'BufReadPost ',
  },
}, {})

-- Local setting if ./lua/local-init.lua exists
pcall(require, 'local-init')

print('Loading init.lua is completed.')
