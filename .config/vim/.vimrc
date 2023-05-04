filetype off

"XDG_CONFIG_HOME
let g:netrw_home = $XDG_CONFIG_HOME."/vim"
set viminfofile=$XDG_CONFIG_HOME/vim/viminfo

"----------------------------------------------------------
" Key Mapping
"----------------------------------------------------------

"カーソルスタイル。INSERTモードでブロックではなくラインに
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

"<Space> をLeaderキーに
let mapleader = "\<Space>"

"Ctrl + s to :w
nnoremap <Leader><CR> :w<CR>
"Ctrl + q to :q
nnoremap <C-q> :q<CR>
"!! to :q!
nnoremap !! :q!<CR>

" jj to normal mode
inoremap <silent> jj <ESC>

"Jで空白なし結合
noremap J gJ
"ctrl+Enterキーで空行挿入
if has('gui_running')
  noremap <C-CR> o<ESC>
else
  noremap <NL> o<ESC>
endif

noremap j gj
noremap k gk

"行移動先を中央表示
noremap gg ggzz

"検索開始時に次の単語に移動させない
noremap * *N
noremap # #N
"検索単語移動＋スクロール
noremap n nzz
noremap N Nzz
"ESCハイライト消去
noremap <silent> <ESC> :nohl<CR><ESC>
"Space + s to replace search highlighted words.
noremap <Leader>s :%s///gc<Left><Left><Left>

noremap <Leader>n :set nonumber!<CR>
noremap <Leader>w :set wrap!<CR>

"----------------------------------------------------------
" Setting
"----------------------------------------------------------
"viとの互換性を優先しない
set nocompatible
"バックスペースキー有効化
set backspace=indent,eol,start
"自動再読み込み
set autoread
"undoファイル生成抑制
set noundofile
" 全角記号カーソル位置補正
set ambiwidth=double

set guifont=Ricty_Diminished:h11
set nobackup
set number
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
" コンソールタイトルにThanks for Flying Vimを出さない
set notitle
"タブと行末の表示
"set list
"括弧のハイライト
set showmatch
"カーソル行ハイライト
set cursorline
set autoindent
set ruler
"検索結果をハイライトする
set hlsearch
"検索時に大文字を含んでいたら大/小を区別
set smartcase
"置換の時 g オプションをデフォルトで有効にする
set gdefault
"ヤンク文字列をクリップボードに
set clipboard=unnamed,autoselect
"自動改行無効
set textwidth=0
set formatoptions=q

set enc=utf-8
set fileformat=unix
set nowrap
"タブを空白に置換
set tabstop=2
set expandtab
"自動インデント幅
set shiftwidth=2
"スワップファイル生成禁止
set noswapfile
" [_]を単語区切りとする
" set iskeyword-=_
"GUIツールバーを非表示
set guioptions-=T
"<C-a>と<C-x>で00xを10進数扱いする
set nrformats=
"light-line用カスタマイズ
"https://github.com/itchyny/lightline.vim
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif
set noshowmode

"色付け
syntax enable
colorscheme default

"開いているファイルのパスをworkingdirectoryとする
set autochdir

"----------------------------------------------------------
" For WSL
"----------------------------------------------------------
" Ubuntu on wsl の vim で日本語入力できない問題の回避
imap <Nul> <Nop>
"wsl の vim がreplace modeで起動してしまう問題の回避
set t_RV=
set t_u7=
"wsl のビープ音を抑制
set belloff=all

