" 挙動を vi 互換ではなく、Vim のデフォルト設定にする
set nocompatible
" 一旦ファイルタイプ関連を無効化する
filetype off

"****************************************
" Vim Options
"****************************************
set tabstop=4 "タブ文字
set shiftwidth=4
set expandtab
set number
set ruler
set laststatus=2
set hlsearch
set background=dark
set backspace=indent,eol,start
" 構文ごとに文字色を変化させる
syntax on

" ステータス行に表示させる情報の指定(どこからかコピペしたので細かい意味はわかっていない)
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
" ステータス行に現在のgitブランチを表示する
set statusline+=%{fugitive#statusline()}


"****************************************
" NeoBundle
"****************************************
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle/'))
endif

" カラースキーマ
NeoBundle 'tomasr/molokai'

" コメントのON/OFFを手軽に実行
NeoBundle 'tomtom/tcomment_vim'

" インデントに色をつけて見やすくする
NeoBundle 'nathanaelkane/vim-indent-guides'

" gitのラッパー
NeoBundle 'tpope/vim-fugitive'

if has('lua') && (( v:version == 703 && has('patch885')) || (v:version >= 704))
      NeoBundle 'Shougo/neocomplete'
  else
        NeoBundle 'Shougo/neocomplcache'
endif
" スニペット
NeoBundle 'Shougo/neosnippet'

" スニペットの定義ファイル集
NeoBundle 'Shougo/neosnippet-snippets'

" スニペットの定義ファイル集(Neosnipettでも使える)
NeoBundle "honza/vim-snippets"

" Sassの色付け、インデント、自動コンパイルを行ってくれる
NeoBundle "AtsushiM/search-parent.vim"
NeoBundle "AtsushiM/sass-compile.vim"

call neobundle#end()

" required!
filetype plugin indent on
filetype indent on


"****************************************
" Color Scheme
"****************************************
colorscheme molokai
set t_Co=256


"****************************************
" Plugin Settings
"****************************************

"******************************
" vim-indent-guides
"******************************
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=234 ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=235 ctermbg=235
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

"******************************
" neosnippet
"******************************
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
 
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" neosnippet-snippet以外のスニペットを読み込む
let g:neosnippet#enable_snipmate_compatibility = 1

" honza/vim-snippetsとの互換性を上げるために一旦無効にする
let g:neosnippet#disable_runtime_snippets = {'_' : 1}

" スニペットの読み込み
let g:neosnippet#snippets_directory = []
let g:neosnippet#snippets_directory += ['~/.vim/bundle/neosnippet-snippets/neosnippets']
if ! empty(neobundle#get("vim-snippets"))
  let g:neosnippet#snippets_directory += ['~/.vim/bundle/vim-snippets/snippets']
endif

" filetypeの自動検出(最後の方に書いたほうがいいらしい)
filetype on


"******************************
" neocomplete
"******************************
if neobundle#is_installed('neocomplete')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#enable_ignore_case = 1

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif 
  let g:neocomplete#keyword_patterns['defaults'] = '\h\w*'
elseif neobundle#is_installed('neocomplcache')
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_smart_case = 1
  let g:neocomplcache_enable_ignore_case = 1

  " Define keyword.
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif 
  let g:neocomplcache_keyword_patterns['defaults'] = '\h\w*'
endif

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

"******************************
" sass-compile
"******************************
let g:sass_compile_auto = 1
let g:sass_compile_file = ['scss', 'sass']
let g:sass_compile_cssdir = ['css', 'stylesheet']
let g:sass_started_dirs = []
" 編集したファイルから遡るフォルダの最大数
let g:sass_compile_cdloop = 5
let g:sass_compile_beforecmd = ""
let g:sass_compile_aftercmd = ""

