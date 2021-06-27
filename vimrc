  
set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" 
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'Vimjas/vim-python-pep8-indent'
" Plugin 'amix/vim-zenroom2'
" Plugin 'chr4/nginx.vim'
" Plugin 'craigemery/vim-autotag'
" Plugin 'garbas/vim-snipmate'
" Plugin 'honza/vim-snippets'
" Plugin 'jalcine/cmake.vim'
" Plugin 'mattn/vim-lsp-settings'
" Plugin 'maxbrunsfeld/vim-yankstack'
" Plugin 'nvie/vim-flake8'
" Plugin 'prabirshrestha/async.vim'
" Plugin 'prabirshrestha/asyncomplete-lsp.vim'
" Plugin 'prabirshrestha/asyncomplete.vim'
" Plugin 'prabirshrestha/vim-lsp'
" Plugin 'scrooloose/syntastic'
" Plugin 'skywind3000/gutentags_plus'
" Plugin 'terryma/vim-expand-region'
" Plugin 'terryma/vim-multiple-cursors'
" Plugin 'tomtom/tlib_vim'
" Plugin 'tpope/vim-markdown'
" Plugin 'tpope/vim-repeat'
" Plugin 'tpope/vim-surround'
" Plugin 'valloric/youcompleteme'
" Plugin 'wvffle/vimterm'
"" " `:help :Glaive` for usage.
"" Also add Glaive, which is used to configure codefmt's maktaba flags. See
"" Plugin 'neoclide/coc.nvim'
Plugin '907th/vim-auto-save'
Plugin 'SirVer/ultisnips'
Plugin 'airblade/vim-gitgutter'
Plugin 'amix/open_file_under_cursor.vim'
Plugin 'bazelbuild/vim-bazel'
Plugin 'codegram/vim-codereview'
Plugin 'crusoexia/vim-monokai'
Plugin 'dense-analysis/ale'
Plugin 'farmergreg/vim-lastplace'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'"
Plugin 'google/vim-maktaba'
Plugin 'grailbio/bazel-compilation-database'
Plugin 'groenewege/vim-less'
Plugin 'heavenshell/vim-pydocstring'
Plugin 'herringtondarkholme/yats.vim'
Plugin 'honza/vim-snippets'
Plugin 'hushicai/tagbar-javascript.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'junkblocker/patchreview-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'majutsushi/tagbar'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'mattn/vim-lsp-settings'
Plugin 'matze/vim-move'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'mikecoder/quickrun.vim'
Plugin 'mileszs/ack.vim'
Plugin 'morhetz/gruvbox'
Plugin 'mru.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'pangloss/vim-javascript'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'rhysd/open-pdf.vim'
Plugin 'rhysd/rust-doc.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'wvffle/vimterm'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'zivyangll/git-blame.vim'


call vundle#end()            " required
filetype plugin indent on    " required

set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim
source ~/.vim_runtime/my_configs.vim

