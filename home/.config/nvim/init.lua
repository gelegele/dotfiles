--[[
My init.lua for NEOVIM

This file path is
Linux: ~/.config/nvim/init.lua
Windows: %LOCALAPPDATA%\nvim\init.lua

How to check health is [:checkhealth]:
]]--

-- Default encoding is utf-8
vim.opt.encoding = "utf-8"
-- Encoding priority list to open existing file.
vim.opt.fileencodings = "utf-8,sjis,cp932,utf-16le"
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

-- keymap option
local keymapopt = { noremap = true, silent = true }
-- Space + Enter to :w
vim.keymap.set('n', '<Leader><CR>', ':w<CR>', keymapopt)
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
vim.keymap.set('n', '<Leader>c', ':bd|bn<CR>', keymapopt)
-- jj to go to NORMAL mode
vim.keymap.set('i', 'jj', '<ESC>', keymapopt)
-- j, k replace gj, gk not to slip wrap lines.
vim.keymap.set('n', 'j', 'gj', keymapopt)
vim.keymap.set('n', 'k', 'gk', keymapopt)
-- J to join lines without space.
vim.keymap.set('n', 'J', 'gJ', keymapopt)
vim.keymap.set('n', 'gg', 'ggzz', keymapopt)
-- Keep the cursor while moving search words 
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
-- Space + h to prefix to open help on new tab.
vim.keymap.set('n', '<Leader>h', ':tab help ', { noremap = true })
-- Space + r to :source $MYVIMRC
vim.keymap.set('n', '<Leader>r', ':source $MYVIMRC<CR>', keymapopt)
-- Space + c to :colorscheme
vim.keymap.set('n', '<Leader><Tab>', ':colorscheme ', { noremap = true })

-- My autocmds
vim.api.nvim_create_augroup( 'my-autocmd', {} )
vim.api.nvim_create_autocmd("BufRead", {
  desc = "Disabled to edit for read-only file.",
  group = 'my-autocmd',
  command = "let &l:modifiable = !&readonly",
})
vim.api.nvim_create_autocmd("BufRead", {
  desc = "Go to EOF when a pattern file is opened.",
  group = 'my-autocmd',
  pattern = "*.log,*/SigmaMemo.txt",
  command = "normal G",
})
vim.api.nvim_create_autocmd("BufEnter", {
  -- didn't work vim.opt.formatoptions
  desc = "Don't auto commenting new lines",
  group = 'my-autocmd',
  command = "set formatoptions-=cro",
})
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text.",
  group = 'my-autocmd',
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
  { -- Install NERD FONT on your OS.
    'nvim-tree/nvim-web-devicons',
  },
  { -- Check startup time
    'dstein64/vim-startuptime',
    cmd = { 'StartupTime' },
  },
  { -- Dashboard
    'glepnir/dashboard-nvim',
    event = "VimEnter",
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
            { desc = ' Config',     group = 'Label', action = 'e $MYVIMRC',                       key = 'c' },
            { desc = ' Lazy',       group = 'Label', action = 'Lazy',                             key = 'L' },
            { desc = ' StartupTime',group = 'Label', action = 'StartupTime --tries 3',            key = 's' },
            { desc = ' zshrc',      group = 'Label', action = 'e ~/.config/zsh/.zshrc',           key = 'z' },
          },
          packages = { enable  = false },
          project = { enable  = false },
          mru = { limit = 8 },
          footer = { '', 'This is your life.', 'Be yourself.' },
        }
      }
      vim.keymap.set('n', '<Leader>d', ':Dashboard<CR>', { desc = 'Open Dashboard', silent = true } )
    end,
  },
  { -- fuzzy finder
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = { { '<Leader>f', mode = 'n' } },
    config = function()
      require('telescope').setup {
        defaults = {
          hidden = true,
        },
      }
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'buffers' })
      vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = 'registers' })
      vim.keymap.set('n', '<leader>fs', builtin.git_status, { desc = 'git status' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'help tags' })
    end
  },
  { -- Filer (Help: ?)
    'nvim-tree/nvim-tree.lua',
    event = "VimEnter",
    config = function()
      -- disable netrw for NvimTree
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      -- Space + e to open the tree.
      vim.keymap.set('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
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
  { 'sainnhe/sonokai' },
  { 'sainnhe/edge' },
  { 'EdenEast/nightfox.nvim' },
  { 'catppuccin/nvim' },
  { 'jacoborus/tender.vim' },
  { 'rmehri01/onenord.nvim' },
  { -- colorscheme switcher
    'zaldih/themery.nvim',
    lazy = false,
    config = function ()
      local themefilepath = '~/.config/nvim/lua/theme.lua'
      if vim.fn.has('win64') == 1 then
        themefilepath = '~\\AppData\\Local\\nvim\\lua\\theme.lua'
      end
      require('themery').setup({
        themes = {
          'vscode', 'ayu', 'catppuccin','sonokai', 'tender', 'tokyonight-night',
          'tokyonight-day', 'edge', 'nightfox', 'duskfox', 'onenord'},
        themeConfigFile = themefilepath,
      })
      pcall(require, 'theme')
      vim.keymap.set('n', '<Leader>T', ':Themery<CR>', { noremap = true })
    end
  },
  { -- Status Line
    'nvim-lualine/lualine.nvim',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('lualine').setup {
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
          lualine_y = { 'g:colors_name' },
          lualine_z = { 'location'},
        }
      }
    end
  },
  { -- buffer tabs
    'romgrk/barbar.nvim',
    event = "VimEnter",
    config = function ()
      vim.keymap.set(
        'n', '<Leader>o', ':BufferCloseAllButCurrent<CR>', { noremap = true })
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
      if vim.fn.has('win64') == 1 then
        -- Disabled to prevent errors on Windows.
        return
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
  },
  {
    'williamboman/mason.nvim',
    event = { 'BufRead', 'BufNewFile' },
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
    event = { 'BufRead', 'BufNewFile' },
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
    event = { 'BufRead', 'BufNewFile' },
  },
  {
    'hrsh7th/cmp-buffer',
    event = { 'BufRead', 'BufNewFile' },
  },
  {
    'hrsh7th/cmp-path',
    event = { 'BufRead', 'BufNewFile' },
  },
  {
    'hrsh7th/cmp-cmdline',
    event = { 'BufRead', 'BufNewFile' },
  },
  {
    'L3MON4D3/LuaSnip',
    event = { 'BufRead', 'BufNewFile' },
  },
  {
    'saadparwaiz1/cmp_luasnip',
    event = { 'BufRead', 'BufNewFile' },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = 'luasnip' },
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
    event = { 'BufRead', 'BufNewFile' },
  },
  { -- My Plugin to toggle highlight search with <C-n>
    'gelegele/hls.nvim',
    keys = {{ '<C-n>', mode = 'n' }},
    config = function ()
      require('hls.nvim').setup()
    end,
  },
  { -- Show shortcut keys
    'folke/which-key.nvim',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require("which-key").setup({})
    end,
  },
  { -- Scroll Bar
    'petertriho/nvim-scrollbar',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('scrollbar').setup({
        handlers = { gitsigns = true, },
      })
    end
  },
  { -- Japanese Help
    'vim-jp/vimdoc-ja',
    event = { 'BufRead', 'BufNewFile' },
  },
  { -- Show git status
    'lewis6991/gitsigns.nvim',
    keys = { { '<Leader>g', mode = 'n' } },
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
          map({'n', 'v'}, '<leader>gd', ':Gitsigns reset_hunk<CR>', { desc = 'reset hunk' })
          map('n', '<leader>gU', gs.stage_buffer, { desc = 'stage buffer' })
          map('n', '<leader>gD', gs.reset_buffer, { desc = 'reset buffer' })
          map('n', '<leader>gf', function() gs.diffthis('~') end, { desc = 'diff HEAD' })
          map('n', '<leader>gb', ':Gitsigns blame_line<CR>', { desc = 'blame the line' })
        end
      })
    end
  },
  { -- Open Lazygit
    'kdheepak/lazygit.nvim',
    keys = { { '<Leader>gl', ':LazyGit<CR>', mode = 'n', desc = 'Open LazyGit' } },
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
  { -- Preview markdown with nodejs
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_auto_close = 0 -- Don't auto close preview
      vim.keymap.set('n', '<leader>m', '<Plug>MarkdownPreview', { desc = 'MarkdownPreview' })
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
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('nvim-surround').setup()
    end
  },
  { -- gcc to comment in/out
    'tpope/vim-commentary',
    keys = {{ 'gcc', mode = { 'n', 'v' }}},
  },
  { -- Extends C-a, C-x
    'monaqa/dial.nvim',
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
      vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), {noremap = true})
      vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), {noremap = true})
    end,
  },
  { -- gs? with motions or Visual select to convert casing.
    --   gs_ -> snake_case
    --   gsc -> camelCase
    --   gsm -> CamelCase
    'arthurxavierx/vim-caser',
    keys = { { 'gs', mode = {'n', 'v'}} },
  },
  { -- Space j to split/join blocks of code.
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {{ "<Leader>j", ':TSJToggle<CR>', mode ='n', desc = 'TSJToggle' }},
    config = function()
      require('treesj').setup({
        use_default_keymaps = false,
      })
    end,
  },
  { -- autoclose and autorename html tag.
    'windwp/nvim-ts-autotag',
    event = { 'BufRead', 'BufNewFile' },
    config = function ()
      require('nvim-ts-autotag').setup()
    end,
  },
  { -- UI for messages, cmdline and the popupmenu.
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {}, -- add any options here
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
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
}, { defaults = { lazy = true }})

-- Local setting if ./lua/local-init.lua exists
pcall(require, 'local-init')
print('init.lua loaded.')