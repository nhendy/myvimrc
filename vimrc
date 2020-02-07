set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'valloric/youcompleteme'
Plugin 'rdnetto/YCM-Generator'
Plugin 'crusoexia/vim-monokai'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'majutsushi/tagbar'
Plugin 'zivyangll/git-blame.vim'
Plugin 'dense-analysis/ale'
" Plugin 'wvffle/vimterm'
" Plugin 'prabirshrestha/async.vim'
" Plugin 'prabirshrestha/asyncomplete.vim'
" Plugin 'prabirshrestha/asyncomplete-lsp.vim'
" Plugin 'prabirshrestha/vim-lsp'
" Plugin 'mattn/vim-lsp-settings'
" Plugin 'scrooloose/syntastic'
Plugin 'matze/vim-move'
Plugin 'ludovicchabant/vim-gutentags'
" Plugin 'skywind3000/gutentags_plus'
Plugin 'craigemery/vim-autotag'
" Plugin '907th/vim-auto-save'
"" Plugin 'neoclide/coc.nvim'
"" Also add Glaive, which is used to configure codefmt's maktaba flags. See
"" " `:help :Glaive` for usage.
"" Plugin 'google/vim-glaive'"


call vundle#end()            " required
filetype plugin indent on    " required

set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

