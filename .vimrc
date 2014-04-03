"----------------------------------------------------------
" Key Mapping
"----------------------------------------------------------
"<Space> も何かに使おう
noremap <Space> <Nop>

"ctrl+j でesc
noremap <C-j> <Esc>
noremap! <C-j> <Esc>
"ノーマルモードでCtrl+Enterキーで改行挿入
noremap <C-CR> o<ESC>
noremap <C-S-CR> O<ESC>
"j/kキーで3倍速スクロール
noremap <C-j> 3jzz
noremap <C-k> 3kzz
"検索開始時に次の単語に移動させない
noremap * *N
noremap # #N
map * <Plug>(visualstar-*)N
map # <Plug>(visualstar-#)N
"検索単語移動＋スクロール
nnoremap n nzz
nnoremap N Nzz
"ヤンク文字列で置換
nnoremap <silent> cy ce<C-r>0<Esc>:let@/=@1<CR>:noh<CR>
vnoremap <silent> cy c<C-r>0<Esc>:let@/=@1<CR>:noh<CR>
nnoremap <silent> ciy ciw<C-r>0<Esc>:let@/=@1<CR>:noh<CR>
"ESC2度押しでハイライト消去
nmap <silent> <ESC><ESC> :nohl<CR><ESC>

"----------------------------------------------------------
" Setting
"----------------------------------------------------------
"viとの互換性を優先しない
set nocompatible
"カーソルキー有効化
set t_ku=OA
set t_kd=OB
set t_kl=OD
set t_kr=OC

"バックスペースキー有効化
set backspace=indent,eol,start
"自動再読み込み
set autoread

set nobackup
set number
set title
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
"GUIツールバーを非表示
set guioptions-=T
"<C-a>と<C-x>で00xを10進数扱いする
set nrformats=
"ステータスライン
set laststatus=2
set statusline=%t\ %r%m%=%c:%l/%L[0x\%04.4B]%y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}

"色付け
syntax on

colorscheme molokai
" colorscheme hybrid

"開いているファイルのパスをworkingdirectoryとする
set autochdir

"多重起動防止
runtime macros/editexisting.vim

"----------------------------------------------------------
" Command
"----------------------------------------------------------
command Sov so ~/.vimrc


"----------------------------------------------------------
" NeoBundle
"----------------------------------------------------------
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

"Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'https://github.com/Shougo/vimproc.git'

" My Bundles here:
"
" Note: You don't set neobundle setting in .gvimrc!
" Original repos on github

"NeoBundle 'https://github.com/Shougo/neocomplcache'
"let g:neocomplcache_enable_at_startup = 1

NeoBundle 'https://github.com/Shougo/neosnippet'
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ?  "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ?  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"unite
NeoBundle 'https://github.com/Shougo/unite.vim.git'
":VimFiler
NeoBundle 'https://github.com/Shougo/vimfiler.git'

NeoBundle 'https://github.com/tpope/vim-fugitive'
NeoBundle 'https://github.com/gregsexton/gitv.git'
"ctrl+y -> ,
NeoBundle 'https://github.com/mattn/emmet-vim.git'
"ステータスラインにモード毎の色を付ける
" NeoBundle 'https://github.com/Lokaltog/vim-powerline.git'
NeoBundle 'https://github.com/itchyny/lightline.vim'

" NeoBundle 'https://github.com/vim-scripts/project.vim.git'
":Rでmvc移動
NeoBundle 'https://github.com/tpope/vim-rails.git'

":Rtreeでrailsツリー表示。vim-railsとセットで
"m でメニュー
"B でブックマーク表示  追加は:BookMark, 削除はD
":NERDTreeFind でファイル位置まで展開
NeoBundle 'https://github.com/scrooloose/nerdtree.git'
"<C-e>でNERDTreeをオンオフ。いつでもどこでも。
map <silent> <C-e>   :NERDTreeToggle<CR>
imap <silent> <C-e>  <Esc>:NERDTreeToggle<CR>

"endを自動入力してくれる
NeoBundle 'https://github.com/tpope/vim-endwise.git'
"\ + r でプログラム実行
NeoBundle 'https://github.com/thinca/vim-quickrun.git'
"ビジュアルモードで*で検索
NeoBundle 'https://github.com/thinca/vim-visualstar.git'
"gcc でコメントアウト
NeoBundle 'https://github.com/tomtom/tcomment_vim.git'
"ctrl+pでファイル一覧
NeoBundle 'https://github.com/kien/ctrlp.vim.git'
"保存時に文法チェック
NeoBundle 'https://github.com/scrooloose/syntastic.git'
"+でtrue/falseをトグル
NeoBundle 'https://github.com/taku-o/vim-toggle.git'
" ys{motion}{surround} cs{old_surround}{new_surround} S{surround} on visual mode
NeoBundle 'https://github.com/tpope/vim-surround'
"Mark行をマークしてくれる
NeoBundle 'https://github.com/vim-scripts/ShowMarks'
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
"vimrcの読み込み時間計測
"NeoBundle 'https://github.com/mattn/benchvimrc-vim.git'

" ...

filetype plugin indent on     " Required!
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
NeoBundleCheck


"----------------------------------------------------------
" .vimr.local
"----------------------------------------------------------
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
