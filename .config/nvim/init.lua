--[[
My init.lua for NEOVIM

This file path is
Linux: ~/.config/nvim/init.lua
Windows: %LOCALAPPDATA%\nvim\init.lua

How to reload this is [:luafile %]
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
-- 自動改行表示しない
vim.opt.wrap = false
-- カーソル行下線
vim.opt.cursorline = true
-- カーソル移動で次の行への移動を許可
vim.opt.whichwrap = "b,s,[,],<,>"
-- enable clipboard sync.
if vim.fn.has("wsl") == 1 then
  -- Suppress clipboard.vim loading delay at startup if wsl.
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", "")',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end
vim.opt.clipboard = 'unnamedplus'

-- floating window と popup nenu を半透明に
vim.opt.winblend = 10
vim.opt.pumblend = 10
-- True Color
vim.opt.termguicolors = true
-- netrw無効化
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Space + Shift + Enter to save
vim.keymap.set('n', '<Leader>w', ':w<CR>')
vim.keymap.set('n', '<Leader>q', ':q<CR>')
vim.keymap.set('n', '<Leader>Q', ':qa!<CR>')
-- Space + p ->  put clipboard text
vim.keymap.set('n', '<Leader>p', '"*p')
vim.keymap.set('n', '<Leader>P', '"*P')
-- Change buffer
vim.keymap.set('n', '<Leader>]', ':bn<CR>')
vim.keymap.set('n', '<Leader>[', ':bp<CR>')
-- Delete buffer
vim.keymap.set('n', '<Leader>x', ':bd|bn<CR>')
-- jj でNORMALモードへ
vim.keymap.set('i', 'jj', '<ESC>')
-- Ctrl + Enterで空行挿入
if vim.fn.has('win64') == 1 then
  vim.keymap.set('n', '<C-CR>', 'o<ESC>')
else
  vim.keymap.set('n', '<NL>', 'o<ESC>')
end
-- Jで空白なし結合
vim.keymap.set('n', 'J', 'gJ')
-- 行移動先を中央表示
vim.keymap.set('n', 'gg', 'ggzz')
-- 検索開始時に次の単語に移動させない
vim.keymap.set('n', '*', '*N')
vim.keymap.set('n', '#', '#N')
-- 検索単語を中央表示
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
-- ESCハイライト消去
vim.keymap.set('n', '<ESC><ESC>', ':nohl<CR><C-l>')
-- 行番号表示トグル
vim.keymap.set('n', '<Leader>n', ':set nonumber!<CR>')
-- Open the tree
vim.keymap.set('n', '<Leader>e', ':NvimTreeToggle<CR>')
-- Focus on the tree
vim.keymap.set('n', '<Leader>h', ':NvimTreeFocus<CR>')


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
          },
          project = { enable  = false },
          shortcut = {
            { desc = ' New',      group = 'Label', action = 'enew',                             key = 'n' },
            { desc = ' Config',   group = 'Label', action = 'e ~/.config/nvim/init.lua',        key = 'c' },
            { desc = ' Update',   group = 'Label', action = 'Lazy update',                      key = 'u' },
            { desc = ' Files',    group = 'Label', action = 'Telescope find_files',             key = 'f' },
            { desc = ' dotfiles', group = 'Label', action = 'Telescope find_files hidden=true', key = 'd' },
          },
          footer = {}
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
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'buffers' })
      vim.keymap.set('n', '<leader>fs', builtin.git_status, { desc = 'git status' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'help tags' })
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
          vim.keymap.set('n', '<Leader>', api.node.open.preview,   opts(bufnr, 'Open Preview'))
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
        ensure_installed = { "bash", "python", "lua", "html", "dockerfile", "javascript" },
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      }
    end
  },
  {
    'folke/which-key.nvim',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  { -- Show indents
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
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
          map({'n', 'v'}, '<leader>gs', ':Gitsigns stage_hunk<CR>', { desc = 'stage hunk' })
          map({'n', 'v'}, '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = 'reset hunk' })
          map('n', '<leader>gS', gs.stage_buffer, { desc = 'stage buffer' })
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
  { -- vwS' Vモード選択した単語を囲う
    -- cs'" シングルをダブルに変更
    'kylechui/nvim-surround',
    event = 'BufRead',
    config = function()
      require('nvim-surround').setup()
    end
  },
  { -- Comment in/out with gcc
    'tpope/vim-commentary',
    event = 'BufRead',
  },
  { -- Space + t でtrue/false切替
    'gerazov/toggle-bool.nvim',
    event = 'BufRead',
    config = function()
      require('toggle-bool').setup({
        mapping = "<leader>t",
      })
    end,
  },
  { -- 自動で括弧閉じ
    'jiangmiao/auto-pairs', 
    event = 'BufReadPost ',
  },
}, {})

-- Local setting if ./lua/local-init.lua exists
pcall(require, 'local-init')

print('Loading init.lua is completed.')
