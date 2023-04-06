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
-- 検索大文字無視
vim.opt.ignorecase = true
-- 大文字で検索したら区別をつける
vim.opt.smartcase = true
-- 自動改行表示しない
vim.opt.wrap = false
-- カーソル行下線
vim.opt.cursorline = true
-- カーソル移動で次の行への移動を許可
vim.opt.whichwrap = "b,s,[,],<,>"
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
-- Change buffer
vim.keymap.set('n', '<Leader>]', ':bn<CR>')
vim.keymap.set('n', '<Leader>[', ':bp<CR>')
-- Delete buffer
vim.keymap.set('n', '<Leader>x', ':bd|bn<CR>')
-- Space + q で終了
vim.keymap.set('n', '<Leader>q', ':q<CR>')
-- Space + Q で全強制終了
vim.keymap.set('n', '<Leader>Q', ':qa!<CR>')
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

          -- Navigation
          map('n', '<leader>g]', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          map('n', '<leader>g[', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          -- Actions
          map({'n', 'v'}, '<leader>gs', ':Gitsigns stage_hunk<CR>')
          map({'n', 'v'}, '<leader>gr', ':Gitsigns reset_hunk<CR>')
          map('n', '<leader>gS', gs.stage_buffer)
          map('n', '<leader>gd', function() gs.diffthis('~') end)
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
