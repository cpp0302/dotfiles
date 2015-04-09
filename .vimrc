
set tabstop=4 "タブ文字

set nocompatible               " be iMproved
filetype off


if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle/'))
endif

" カラースキーマ
NeoBundle 'tomasr/molokai'

call neobundle#end()

filetype plugin indent on     " required!
filetype indent on
syntax on

" カラースキーマの設定
colorscheme molokai
set t_Co=256
