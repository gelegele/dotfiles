--[[
My init.lua for NEOVIM

How to reload this is [:luafile %]

How to check health is [:checkhealth]:

]]--

-- Leaderはスペース
vim.g.mapleader = ' '       
vim.g.maplocalleader = ' '
-- TABとシフトインデントは4
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- 行番号表示 :set number <-> :set nonumber
vim.opt.number = true
-- ハイライトサーチ
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
-- Fernの起動
vim.keymap.set('n', '<C-n>', ':Fern . -reveal=% -drawer -toggle<CR>')


-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  { -- ファイラー
    'lambdalisue/fern.vim',
    config = function()
      -- 隠しファイルをデフォルト表示
      vim.g['fern#default_hidden'] = 1
    end
  },
  { -- netrw無効化（Fern使用）
    'lambdalisue/fern-hijack.vim'
  },
  { -- ステータスライン
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  { -- ColorScheme
    'marko-cerovac/material.nvim',
    config = function()
      -- スタイル確認コマンドはこれ
      -- :lua require('material.functions').toggle_style()
      vim.g.material_style = 'darker'
      vim.cmd.colorscheme 'material'
    end,
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
  { -- gccでコメントアウト
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
  }
}, {})
