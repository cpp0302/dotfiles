
set tabstop=4 "タブ文字

set nocompatible               " be iMproved
filetype off


if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle/'))
endif

call neobundle#end()

filetype plugin indent on     " required!
filetype indent on
syntax on
