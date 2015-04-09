
set tabstop=4 "タブ文字
set shiftwidth=4
set expandtab

set nocompatible               " be iMproved
filetype off

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

call neobundle#end()

filetype plugin indent on     " required!
filetype indent on
syntax on

" カラースキーマ
colorscheme molokai
set t_Co=256

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=234 ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=235 ctermbg=235
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
