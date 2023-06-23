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
vim.opt.fileencodings = "utf-8,sjis,cp932"
-- disable netrw for NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
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
  -- The path to win32yank is passed if Windows Neovim is installed with winget.
  vim.g.clipboard = {
    name  = 'WslClipboard',
    copy  = { ['+'] = 'win32yank.exe -i', ['*'] = 'win32yank.exe -i' },
    paste = { ['+'] = 'win32yank.exe -o', ['*'] = 'win32yank.exe -o' },
    cache_enabled = 0,
  }
end
vim.opt.clipboard = 'unnamedplus'

-- pseudo-transparency for a floating window and the popup menu.
vim.opt.winblend = 10
vim.opt.pumblend = 10
-- True Color
vim.opt.termguicolors = true


-- keymap option
local keymapopt = { noremap = true, silent = true }
-- Space + Enter to :w
vim.keymap.set('n', '<Leader><CR>', ':w<CR>', keymapopt)
-- Q to :q
vim.keymap.set('n', 'Q', ':q<CR>', keymapopt)
-- !! to :q!
vim.keymap.set('n', '!!', ':qa!<CR>', keymapopt)
-- TAB to add new line.
vim.keymap.set('n', '<Tab>', 'o<ESC>', keymapopt)
vim.keymap.set('n', '<S-Tab>', 'O<ESC>', keymapopt)
-- Space + p to put clipboard text
vim.keymap.set('n', '<Leader>p', '"*p', keymapopt)
vim.keymap.set('n', '<Leader>P', '"*P', keymapopt)
-- Space + [ to change buffer
vim.keymap.set('n', '<Leader>]', ':bn<CR>', keymapopt)
vim.keymap.set('n', '<Leader>[', ':bp<CR>', keymapopt)
-- Space + x to delete buffer
vim.keymap.set('n', '<Leader>x', ':bd|bn<CR>', keymapopt)
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
-- Space + e to open the tree.
vim.keymap.set('n', '<Leader>e', ':NvimTreeToggle<CR>', keymapopt)
-- Space + r to :source $MYVIMRC
vim.keymap.set('n', '<Leader>r', ':source $MYVIMRC<CR>', keymapopt)
-- Key command Reminder
-- <C-]> to go to the section of the word under the cursor in Help. <C-t> is back.

-- TODO create plugin
if pcall(require, 'togglehls') then
  local ToggleHls = require("togglehls")
  vim.keymap.set('n', '<C-n>', ToggleHls.toggle)
else
  function ToggleHls()
    if vim.v.hlsearch == 1 then
      vim.cmd('nohl')
    else
      vim.api.nvim_feedkeys("*", "m", true)
    end
  end
  vim.keymap.set('n', '<C-n>', ':lua ToggleHls()<CR>')
end

-- My autocmds
vim.api.nvim_create_autocmd("BufRead", {
  desc = "Disabled to edit for read-only file.",
  command = "let &l:modifiable = !&readonly",
})
vim.api.nvim_create_autocmd("BufRead", {
  desc = "Go to EOF when SigmaMemo.txt is opened.",
  pattern = "*/SigmaMemo.txt",
  command = "normal G",
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
    lazy = true
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
            { desc = ' zshrc',      group = 'Label', action = 'e ~/.config/zsh/.zshrc',           key = 'z' },
            { desc = ' Lazy',       group = 'Label', action = 'Lazy',                             key = 'L' },
            { desc = ' Files',      group = 'Label', action = 'Telescope find_files hidden=true', key = 'f' },
            { desc = ' StartupTime',group = 'Label', action = 'StartupTime --tries 3',            key = 's' },
          },
          packages = { enable  = false },
          project = { enable  = false },
          mru = { limit = 8 },
          footer = { '', 'This is your life.', 'Be yourself.' },
        }
      }
      vim.keymap.set('n', '<Leader>d', ':Dashboard<CR>', { desc = 'Open Dashboard' } )
    end,
  },
  { -- fuzzy finder
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        defaults = {
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
      vim.keymap.set('n', '<leader>tr', builtin.registers, { desc = 'registers' })
      vim.keymap.set('n', '<leader>ts', builtin.git_status, { desc = 'git status' })
      vim.keymap.set('n', '<leader>th', builtin.help_tags, { desc = 'help tags' })
    end
  },
  { -- Filer (Help: ?)
    'nvim-tree/nvim-tree.lua',
    -- No event mapping is faster than event = "VimEnter"
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
  { 'Mofiqul/vscode.nvim',
    priority = 1000,
    config = function()
      -- Prevent error on VS Code
      if not vim.g.vscode then
        vim.cmd.colorscheme 'vscode'
      end
    end,
  },
  { -- Status Line
    'nvim-lualine/lualine.nvim',
    event = { "InsertEnter", "CursorHold", "FocusLost", "BufRead", "BufNewFile" },
    config = function()
      require('lualine').setup {
        options = {
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
        }
      }
    end
  },
  { -- buffer tabs
    'romgrk/barbar.nvim',
    config = function ()
      vim.keymap.set(
        'n', '<Leader>c', ':BufferCloseAllButCurrent<CR>', { noremap = true })
      require('barbar').setup {
        -- offset for NvimTree
        sidebar_filetypes = { NvimTree = true, }
      }
    end
  },
  { -- Tree-sitter
    'nvim-treesitter/nvim-treesitter',
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
    'hrsh7th/cmp-buffer',
  },
  {
    'hrsh7th/cmp-path',
  },
  {
    'hrsh7th/cmp-cmdline',
  },
  {
    'L3MON4D3/LuaSnip',
  },
  {
    'saadparwaiz1/cmp_luasnip',
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
        handlers = { gitsigns = true, },
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
  { -- Open Lazygit
    'kdheepak/lazygit.nvim',
    event = 'BufRead',
    config = function()
      vim.keymap.set('n', '<Leader>gl', ':LazyGit<CR>')
    end,
  },
  { -- Seamless window selection with tmux
    'christoomey/vim-tmux-navigator',
  },
  { -- resize nvim/tmux pane with the same hotkeys
    -- as Alt-h, Alt-j, Alt-k, Alt-l
    'RyanMillerC/better-vim-tmux-resizer'
  },
  { -- Preview markdown with nodejs
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.keymap.set('n', '<leader>m', '<Plug>MarkdownPreviewToggle', { desc = 'MarkdownPreviewToggle' })
    end,
  },
  { -- Rainbow CSV
    'mechatroner/rainbow_csv',
    ft = { 'csv' },
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
  { -- Extends C-a, C-x
    'monaqa/dial.nvim',
    event = 'BufRead',
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
      vim.keymap.set("n", "g<C-a>", require("dial.map").inc_gnormal(), {noremap = true})
      vim.keymap.set("n", "g<C-x>", require("dial.map").dec_gnormal(), {noremap = true})
      vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), {noremap = true})
      vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), {noremap = true})
      vim.keymap.set("v", "g<C-a>",require("dial.map").inc_gvisual(), {noremap = true})
      vim.keymap.set("v", "g<C-x>",require("dial.map").dec_gvisual(), {noremap = true})
    end,
  },
  { -- Automatically close brackets
    'windwp/nvim-autopairs',
    event = 'BufRead',
    config = function ()
      require('nvim-autopairs').setup({check_ts = true})
    end,
  },
  { -- gs? with motions or Visual select to convert casing.
    --   gs_ -> snake_case
    --   gsc -> camelCase
    --   gsm -> CamelCase
    'arthurxavierx/vim-caser',
    event = 'BufRead',
  },
  { -- Space j to split/join blocks of code.
    'Wansmer/treesj',
    event = 'BufRead',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup(
        { use_default_keymaps = false }
      )
      vim.keymap.set("n", "<Leader>j", ':TSJToggle<CR>', { desc = 'TSJToggle' })
    end,
  },
  { -- autoclose and autorename html tag.
    'windwp/nvim-ts-autotag',
    event = 'BufRead',
    config = function ()
      require('nvim-ts-autotag').setup()
    end,
  },
}, {})

-- Local setting if ./lua/local-init.lua exists
pcall(require, 'local-init')

print('Loading init.lua is completed.')
