--[[
My init.lua for NEOVIM

  If you want to refer this file from Windows Neovim,
  Execute the following command on MS-DOS as Administrator.
  > mklink [Home Dir]\AppData\Local\nvim\init.lua [Drive]:[Path to this file]\init.lua 

]]--

-- Default encoding is utf-8
vim.opt.encoding = "utf-8"
-- Encoding priority list to open existing file.
vim.opt.fileencodings = "utf-8,sjis,cp932,utf-16le"
-- Leader key is space.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- show cursor line without number.
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'line'
-- I don't need swap files.
vim.opt.swapfile = false
-- tab space is 2.
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- how many lines are shown around the cursor when scrolling vertically.
vim.opt.scrolloff = 5
-- Show line numbers.
vim.opt.number = true
-- Show tail spaces.
vim.opt.list = true
-- ignore case
vim.opt.ignorecase = true
-- case-sensitive if capital letters
vim.opt.smartcase = true
-- Allow keys below that move the cursor to move to the pre/next line.
vim.opt.whichwrap = "b,[,],<,>"
-- enable clipboard sync.
if vim.fn.has("wsl") == 1 then
  -- The path to win32yank is passed if Windows Neovim is installed with winget.
  vim.g.clipboard = {
    name  = 'WslClipboard',
    copy  = { ['+'] = 'win32yank.exe -i', ['*'] = 'win32yank.exe -i' },
    paste = { ['+'] = 'win32yank.exe -o --lf', ['*'] = 'win32yank.exe -o --lf' },
    cache_enabled = 0,
  }
end
vim.opt.clipboard = 'unnamedplus'
-- pseudo-transparency for a floating window and the popup menu.
vim.opt.winblend = 10
vim.opt.pumblend = 10
-- True Color
vim.opt.termguicolors = true
vim.opt.helplang = 'ja,en'
-- Show file name on GUI
vim.opt.title = true
vim.opt.titlestring = '%t'
-- disable plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_matchparen = 1

-- keymap option
local keymapopt = { noremap = true, silent = true }
-- Space + Enter to :w
if vim.g.vscode then
  vim.keymap.set('n', '<Leader><CR>', ':call VSCodeCall("workbench.action.files.save")<CR>', { noremap = true })
else
  vim.keymap.set('n', '<Leader><CR>', ':w<CR>', keymapopt)
end
-- Q to :q
vim.keymap.set('n', 'Q', ':q<CR>', keymapopt)
-- !! to :q!
vim.keymap.set('n', '!!', ':qa!<CR>', keymapopt)
-- Shift + TAB to add a new line while remaining in normal mode.
vim.keymap.set('n', '<S-Tab>', 'o<ESC>', keymapopt)
-- Ctrl + p to paste yanked text
vim.keymap.set({'n', 'v'}, '<C-p>', '"0p', keymapopt)
-- Space + [ to change buffer
vim.keymap.set('n', '<Leader>]', ':bn<CR>', keymapopt)
vim.keymap.set('n', '<Leader>[', ':bp<CR>', keymapopt)
-- Space + x to delete buffer
vim.keymap.set('n', '<Leader>x', ':bd|bn<CR>', keymapopt)
-- jj and kk to go to NORMAL mode
vim.keymap.set('i', 'jj', '<ESC>', keymapopt)
vim.keymap.set('i', 'kk', '<ESC>', keymapopt)
-- j, k replace gj, gk not to slip wrap lines.
vim.keymap.set('n', 'j', 'gj', keymapopt)
vim.keymap.set('n', 'k', 'gk', keymapopt)
-- J to join lines without space.
vim.keymap.set('n', 'J', 'gJ', keymapopt)
vim.keymap.set('n', 'gg', 'ggzz', keymapopt)
-- indent a visual block repeatedly.
vim.keymap.set('v', '<', '<gv', keymapopt)
vim.keymap.set('v', '>', '>gv', keymapopt)
-- Keep the cursor while moving search words.
vim.keymap.set('n', 'n', 'nzz', keymapopt)
vim.keymap.set('n', 'N', 'Nzz', keymapopt)
-- Don't move the cursor when starting a word search.
vim.keymap.set('n', '*', '*N', keymapopt)
vim.keymap.set('n', '#', '#N', keymapopt)
-- ESC to clear search highlight.
vim.keymap.set('n', '<ESC><ESC>', ':nohl<CR>', keymapopt)
-- Space + s to replace search highlighted words.
vim.keymap.set('n', '<Leader>s', ':%s///gc<Left><Left><Left>', { noremap = true })
-- Space + n to toggle line numbers.
vim.keymap.set('n', '<Leader>n', ':set nonumber!<CR>', keymapopt)
-- Space + w to toggle auto wrap.
vim.keymap.set('n', '<Leader>w', ':set wrap!<CR>', keymapopt)
-- Space + h to prefix to open help on new tab. To go back with gt.
vim.keymap.set('n', '<Leader>h', ':tab help ', { noremap = true })
-- Space + Tab to :colorscheme
vim.keymap.set('n', '<Leader><Tab>', ':colorscheme ', { noremap = true })

-- My autocmds
vim.api.nvim_create_augroup( 'my-autocmd', {} )
vim.api.nvim_create_autocmd("BufRead", {
  desc    = "Disabled to edit for read-only file.",
  group   = 'my-autocmd',
  command = "let &l:modifiable = !&readonly",
})
vim.api.nvim_create_autocmd("BufRead", {
  desc    = "Disabled auto completion in txt buffer.",
  group   = 'my-autocmd',
  pattern = "*.txt",
  command = "lua require('cmp').setup({ completion = { autocomplete = false } })",
})
vim.api.nvim_create_autocmd("BufRead", {
  desc    = "Go to EOF when a pattern file is opened.",
  group   = 'my-autocmd',
  pattern = "*.log,*/SigmaMemo.txt",
  command = "normal G",
})
vim.api.nvim_create_autocmd("BufEnter", {
  -- didn't work vim.opt.formatoptions
  desc    = "Don't auto commenting new lines",
  group   = 'my-autocmd',
  command = "set formatoptions-=cro",
})
vim.api.nvim_create_autocmd("TextYankPost", {
  desc    = "Highlight yanked text.",
  group   = 'my-autocmd',
  command = "lua vim.highlight.on_yank { higroup='IncSearch', timeout=300 }",
})

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
  { -- Check startup time
    'dstein64/vim-startuptime',
    cmd = { 'StartupTime' },
  },
  { -- Dashboard
    'nvimdev/dashboard-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VimEnter",
    config = function()
      local version = vim.version()
      require('dashboard').setup {
        config ={
          header = {
            [[ ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗ ]],
            [[ ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║ ]],
            [[ ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║ ]],
            [[ ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║ ]],
            [[ ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║ ]],
            [[ ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝ ]],
            'v'..version.major..'.'..version.minor..'.'..version.patch,
            [[                                                        ]],
          },
          shortcut = {
            { desc = ' New',        group = 'Label', action = 'enew',                   key = 'n' },
            { desc = ' Config',     group = 'Label', action = 'e $MYVIMRC',             key = 'c' },
            { desc = ' Lazy',       group = 'Label', action = 'Lazy',                   key = 'L' },
            { desc = '󰚰 Mason',      group = 'Label', action = 'Mason',                  key = 'M' },
            { desc = ' StartupTime',group = 'Label', action = 'StartupTime --tries 3',  key = 's' },
            { desc = '󰋢 checkhealth',group = 'Label', action = 'checkhealth',            key = 'h' },
            { desc = ' zshrc',      group = 'Label', action = 'e ~/.config/zsh/.zshrc', key = 'z' },
          },
          packages = { enable = true },
          project  = { enable = false },
          mru      = { limit = 8 },
          footer   = { '', 'This is your life. Be yourself.' },
        }
      }
      vim.keymap.set('n', '<Leader>d', ':Dashboard<CR>', keymapopt )
    end,
  },
  { -- fuzzy finder
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-lua/plenary.nvim' },
    keys = {{ '<Leader>f', mode = 'n', desc = 'telescope' }},
    config = function()
      require('telescope').setup({ defaults = { hidden = true } })
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep,  { desc = 'live grep'  })
      vim.keymap.set('n', '<leader>fb', builtin.buffers,    { desc = 'buffers'    })
      vim.keymap.set('n', '<leader>fr', builtin.registers,  { desc = 'registers'  })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags,  { desc = 'help tags'  })
    end
  },
  { -- Filer (Help: ?)
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VimEnter",
    config = function()
      -- Space + e to open the tree.
      vim.keymap.set('n', '<Leader>e', ':NvimTreeToggle<CR>', keymapopt)
      -- If buffer is a dir, change to the dir and open the tree.
      local function open_nvim_tree(data)
        if vim.fn.isdirectory(data.file) == 1 then
          vim.cmd.cd(data.file)
          require("nvim-tree.api").tree.open()
        end
      end
      vim.api.nvim_create_autocmd({ "VimEnter" },
        {
          desc = 'Open nvim-tree if dir.',
          group = 'my-autocmd',
          callback = open_nvim_tree
        }
      )
      -- My keymaps
      require("nvim-tree").setup({
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")
          local function opts(buffer, desc)
            return { desc = desc, buffer = buffer, noremap = true, silent = true, nowait = true }
          end
          api.config.mappings.default_on_attach(bufnr)
          vim.keymap.set('n', '?', api.tree.toggle_help,           opts(bufnr, 'Help'))
          vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts(bufnr, 'Close Directory'))
          vim.keymap.set('n', 'l', api.node.open.edit,             opts(bufnr, 'Open Edit'))
        end,
      })
    end
  },
  -- colorschemes
  { 'Mofiqul/vscode.nvim' },
  { 'Shatur/neovim-ayu' },
  { 'folke/tokyonight.nvim' },
  { 'sainnhe/edge' },
  { 'EdenEast/nightfox.nvim' },
  { 'catppuccin/nvim' },
  { 'jacoborus/tender.vim' },
  { "savq/melange-nvim" },
  { -- colorscheme switcher
    'zaldih/themery.nvim',
    lazy = false,
    config = function ()
      -- ~/.config/nvim/lua/theme.lua
      -- ~\\AppData\\Local\\nvim\\lua\\theme.lua
      require('themery').setup({
        themes = {
          'default', 'habamax', 'slate', 'quiet', 'ayu-mirage', 'melange',
          'vscode', 'tender', 'tokyonight-night', 'tokyonight-storm', 'edge',
          'nightfox', 'duskfox', 'catppuccin-mocha', 'catppuccin-macchiato',
        },
      })
      pcall(require, 'theme')
      vim.keymap.set('n', '<Leader>T', ':Themery<CR>', keymapopt)
    end
  },
  { -- Status Line
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = { 'BufRead', 'BufNewFile' },
    opts = {
      options = {
        theme = 'papercolor_dark',
        component_separators = '',
        path = 1, -- 0:filename(default), 1:relative, 2:absolute
        symbols = { readonly = '[]' },
        disabled_filetypes = {'NvimTree'}, -- Hide in nvim-tree
      },
      sections = {
        lualine_b = {
          { 'branch',},
          { 'diff', },
          {
            'diagnostics',
            -- Don't use icons to prevent ui corruption by lualine line-breaking
            icons_enabled = false,
          },
        },
        lualine_x = {
          'encoding', 'fileformat', 'filetype',
          { 'copilot', show_colors = true, }, -- copilot-lualine
        },
        lualine_y = { 'g:colors_name' },
        lualine_z = { 'location'},
      },
    },
  },
  { -- buffer tabs
    'romgrk/barbar.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'lewis6991/gitsigns.nvim' },
    event = "VimEnter",
    config = function ()
      vim.keymap.set('n', '<Leader>o', ':BufferCloseAllButCurrent<CR>', keymapopt)
      require('barbar').setup {
        -- offset for NvimTree
        sidebar_filetypes = { NvimTree = true, }
      }
    end
  },
  { -- Tree-sitter
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufRead', 'BufNewFile' },
    build = ':TSUpdate',
    config = function()
      if vim.fn.has('win64') then
        return -- Disabled to prevent errors on Windows.
      end
      require('nvim-treesitter.configs').setup {
        auto_install = true,
        highlight = { enable = true, },
        indent = { enable = true, },
      }
    end
  },
  { -- Show indents
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufRead', 'BufNewFile' },
    main = "ibl",
    opts = {},
  },
  { -- Enhanced matchparen
    "utilyre/sentiment.nvim",
    event = "VeryLazy",
    opts = {},
  },
  { -- Langage Server manager
    'williamboman/mason.nvim',
    event = "VeryLazy",
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      { 'folke/neodev.nvim', opts = {} },
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      if vim.fn.has('win64') == 1 then
        -- No LSP on Windows
        return
      end
      require('mason').setup()
      require('mason-lspconfig').setup {}
      require("mason-lspconfig").setup_handlers {
        function (server_name) -- default handler (optional)
          local opts = {}
          opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
          opts.settings = {
            Lua = { diagnostics = { globals = { 'vim', 'cond' } } }
          }
          require("lspconfig")[server_name].setup(opts)
        end,
      }
    end,
  },
  { -- completion
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", 'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim',      -- adds vscode-like pictograms
    },
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        formatting = {
          format = require('lspkind').cmp_format({ mode = 'symbol' }),
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = 'luasnip' },
          { name = "buffer" },
          { name = "path" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ['<C-l>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ["<CR>"]  = cmp.mapping.confirm { select = true },
        }),
        experimental = {
          ghost_text = true,
        },
      })
      -- Use buffer source for `/` and `?`
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
      -- Use cmdline & path source for ':'
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
            {
              name = 'cmdline',
              option = {
                ignore_cmds = { 'Man', '!' }
              }
            }
          })
      })
      -- Toggle autocomplete
      local function toggle_autocomplete()
        local current_setting = cmp.get_config().completion.autocomplete
        if current_setting and #current_setting > 0 then
          cmp.setup({ completion = { autocomplete = false } })
          vim.notify('Autocomplete disabled')
        else
          cmp.setup({ completion = { autocomplete = { cmp.TriggerEvent.TextChanged } } })
          vim.notify('Autocomplete enabled')
        end
      end
      vim.api.nvim_create_user_command('NvimCmpToggle', toggle_autocomplete, {})
      vim.keymap.set('n', '<leader>C', ':NvimCmpToggle<CR>', keymapopt)
    end,
  },
  { -- My Plugin to toggle highlight search with <C-n>
    'gelegele/hls.nvim',
    cond = true, -- enabled in vscode
    keys = {{ '<C-n>', mode = 'n' }},
    config = function () -- TODO opts
      require('hls.nvim').setup()
    end,
  },
  { -- Show shortcut keys
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {{
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Show Local Keymaps",
    }},
  },
  { -- Scroll Bar
    'petertriho/nvim-scrollbar',
    dependencies = { 'lewis6991/gitsigns.nvim' },
    event = { 'BufRead', 'BufNewFile' },
    opts = { handlers = { gitsigns = true } }
  },
  { -- Japanese Help
    'vim-jp/vimdoc-ja',
    event = 'VeryLazy',
  },
  { -- Show git status
    'lewis6991/gitsigns.nvim',
    opts = {
      signcolumn = false,
      numhl = true,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function next_hunk()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end
        local function prev_hunk()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        map('n', '<leader>g]', next_hunk, { desc='next hunk', expr=true })
        map('n', '<leader>g[', prev_hunk, { desc='prev hunk', expr=true })
        map({'n', 'v'}, '<leader>gs', ':Gitsigns stage_hunk<CR>', { desc = 'stage hunk' })
        map({'n', 'v'}, '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = 'reset hunk' })
        map('n', '<leader>gd', function() gs.diffthis('~') end, { desc = 'diff HEAD' })
        map('n', '<leader>gb', ':Gitsigns blame_line<CR>', { desc = 'blame the line' })
        map('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', { desc = 'preview the hunk' })
      end,
    },
  },
  { -- Open Lazygit
    'kdheepak/lazygit.nvim',
    keys = {{ '<Leader>gl', ':LazyGit<CR>', mode = 'n', desc = 'LazyGit' }},
  },
  { -- Seamless window selection with tmux
    'christoomey/vim-tmux-navigator',
    event = 'VimEnter',
  },
  { -- resize nvim/tmux pane with the same hotkeys
    -- as Alt-h, Alt-j, Alt-k, Alt-l
    'RyanMillerC/better-vim-tmux-resizer',
    event = 'VimEnter',
  },
  { -- <Leader>\ to toggle terminal
    'akinsho/toggleterm.nvim',
    config = {
      direction = 'float',
      float_opts = { width = 100, height = 18 },
    },
    keys = {
      { '<Leader>\\', ':ToggleTerm<CR>', mode = 'n', desc = 'ToggleTerm', },
      { '<Leader>\\', '<C-\\><C-n>:ToggleTerm<CR>', mode = 't', desc = 'ToggleTerm', },
      { '<ESC>', '<C-\\><C-n>', mode = 't', desc = 'exit from terminal insert mode', },
    },
  },
  { -- Preview markdown with nodejs
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = ":call mkdp#util#install()",
    config = function()
      vim.g.mkdp_auto_close = 0 -- Don't auto close preview
      vim.keymap.set('n', '<leader>m', '<Plug>MarkdownPreview', keymapopt)
    end,
  },
  { -- Rainbow CSV
    'mechatroner/rainbow_csv',
    ft = { 'csv' },
  },
  { -- vwS' to quote the v-mode selected word.
    -- cs'" to change single quotation to double quotation.
    -- ds" to delete quatation.
    'kylechui/nvim-surround',
    cond = true, -- enabled in vscode
    event = { 'BufRead', 'BufNewFile' },
    opts = {},
  },
  { -- gcc to toggle linewise comment. gbc to toggle blockwise comment.
    'numToStr/Comment.nvim',
    keys = { -- setting for lazy loading
      { 'gc', mode = { 'n', 'v' }},
      { 'gb', mode = { 'n', 'v' }},
    },
    opts = {},
  },
  { -- Extends C-a, C-x
    'monaqa/dial.nvim',
    cond = true, -- enabled in vscode
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group{
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%Y年%-m月%-d日"],
          augend.date.alias["%m/%d"],
          -- augend.date.alias["%-m月%-d日"],
          augend.date.alias["%H:%M"],
          augend.constant.alias.ja_weekday,
          augend.constant.alias.bool,
        },
      }
      vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), keymapopt)
      vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), keymapopt)
    end,
  },
  { -- gs? with motions or Visual select to convert casing.
    --   gs_ -> snake_case
    --   gsc -> camelCase
    --   gsm -> CamelCase
    'arthurxavierx/vim-caser',
    keys = { { 'gs', mode = {'n', 'v'}, desc = 'caser'} },
  },
  { -- Space j to split/join blocks of code.
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {{ "<Leader>j", ':TSJToggle<CR>', mode ='n', desc = 'TSJToggle' }},
    opts = { use_default_keymaps = false },
  },
  { -- autopair
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
  { -- autoclose and autorename html tag.
    'windwp/nvim-ts-autotag',
    event = { 'BufRead', 'BufNewFile' },
    opts = {},
  },
  { -- align rows with key ga in visual mode.
    'junegunn/vim-easy-align',
    keys = {{ 'ga', '<Plug>(EasyAlign)=', mode = 'v' }},
  },
  { -- UI for messages, cmdline and the popupmenu.
    -- If you get many error messages, :NoiceDisable to clear them.
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    keys = {{ "<Leader>m", ":Noice<CR>", mode = "n", desc = "messages by Noice" }},
    config = function()
      if vim.fn.has('win64') == 1 then
        return -- Disabled to prevent flicker on Windows.
      end
      require("noice").setup({
        messages = {
          view      = "mini",
          view_warn = "mini",
        },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
      })
    end,
  },
  { -- open links without netrw
    'chrishrb/gx.nvim',
    dependencies = { "nvim-lua/plenary.nvim" },
    cond = true, -- enabled in vscode
    keys = {{ "gx", "<cmd>Browse<cr>", mode = { "n", "x" } }},
    cmd = { "Browse" },
    opts = {},
  },
  { -- github copilot
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = { "Copilot" },
    event = { "InsertEnter" },
    opts = {
      filetypes = { gitcommit = true }, -- enabled in gitcommit
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<Tab>", -- Default was "<M-l>"
          -- accept_word = false,
          -- accept_line = false,
          -- next = "<M-]>",
          -- prev = "<M-[>",
          -- dismiss = "<C-]>",
        },
      },
    },
  },
  { -- github copilot status icon in lualine
    'AndreM222/copilot-lualine',
  },
  { -- github copilot chat
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "github/copilot.vim", "nvim-lua/plenary.nvim" },
    build = "make tiktoken",
    keys = {{ "<Leader>c", ':CopilotChat<CR>', mode ='n', desc = 'CopilotChat' }},
    opts = {},
  },
},
{
  defaults = {
      cond ~= vim.g.vscode, -- most plugins are disabled in vscode
      lazy = true,
    }
})

-- Local setting if ./lua/local-init.lua exists
pcall(require, 'local-init')
