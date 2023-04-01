--[[
My init.lua for NEOVIM

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

-- Space + Enterで保存
vim.keymap.set({'n', 'i'}, '<Leader><CR>', ':w<CR>')
-- Q で終了
vim.keymap.set('n', 'Q', ':q<CR>')
-- Space + q で強制終了
vim.keymap.set('n', '<Leader>Q', ':q!<CR>')
-- jj でNORMALモードへ
vim.keymap.set('i', 'jj', '<ESC>')
-- Ctrl + Enterで空行挿入
vim.keymap.set('n', '<NL>', 'o<ESC>')
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
vim.keymap.set('n', '<Leader>g', ':set nonumber!<CR><C-l>')
-- filerの起動
vim.keymap.set('n', '<Leader>e', ':NvimTreeToggle<CR><C-l>')

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
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
  { -- Filer (Help: g+?)
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      { -- Install NERD FONT on your OS.
        'nvim-tree/nvim-web-devicons',
      }
    },
    config = function()
      require("nvim-tree").setup({
        -- open_on_setup = true -- Show filer if not file.
      })
    end
  },
  { 'olimorris/onedarkpro.nvim',
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
  { 'NLKNguyen/papercolor-theme', },
  { 'sonph/onehalf' },
  { -- Status Line
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
        path = 2, -- 0:filename, 1:relative, 2:absolute
        disabled_filetypes = {'NvimTree'}, -- Hide on nvim-tree
      },
    },
  },
  { -- Show indents
    'lukas-reineke/indent-blankline.nvim',
  },
  { -- Scroll Bar
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup({
        handlers = {
          cursor = false,  -- Hide cursor mark on bar
          gitsigns = true, -- Requires gitsigns
        },
      })
    end
  },
  { -- Show git status
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  { -- vwS' Vモード選択した単語を囲う
    -- cs'" シングルをダブルに変更
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({
          -- Configuration here, or leave empty to use defaults
      })
    end
  },
  { -- Comment in/out with gcc
    'tpope/vim-commentary',
    event = 'VeryLazy',
  },
  { -- 自動で括弧閉じ
    'jiangmiao/auto-pairs', 
    event = 'VeryLazy',
  },
  { -- Space + t でtrue/false切替
    'gerazov/toggle-bool.nvim',
    event = 'VeryLazy',
    config = function()
      require('toggle-bool').setup({
        mapping = "<leader>t",
      })
    end,
  },
}, {})

-- If buffer is a dir, change to the dir and open the tree.
local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1
  if not directory then
    return
  end
  vim.cmd.cd(data.file)
  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- TODO
-- - スペース入力にラグが発生する
-- - Clipboard
-- - 画面分割の習得
