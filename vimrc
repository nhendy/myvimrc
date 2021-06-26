  
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
" Plugin 'craigemery/vim-autotag'
Plugin '907th/vim-auto-save'
"" Plugin 'neoclide/coc.nvim'
"" Also add Glaive, which is used to configure codefmt's maktaba flags. See
"" " `:help :Glaive` for usage.
Plugin 'google/vim-glaive'"
" Plugin 'scrooloose/nerdtree'
" Plugin 'mileszs/ack.vim'
" Plugin 'kien/ctrlp.vim'
" Plugin 'mru.vim'
" Plugin 'jlanzarotta/bufexplorer'
" Plugin 'chr4/nginx.vim'
" Plugin 'amix/open_file_under_cursor.vim'
" Plugin 'tpope/vim-commentary'
" Plugin 'terryma/vim-expand-region'
" Plugin 'nvie/vim-flake8'
" Plugin 'tpope/vim-fugitive'
" 
" Plugin 'airblade/vim-gitgutter'
" Plugin 'michaeljsmith/vim-indent-object'
" Plugin 'pangloss/vim-javascript'
" Plugin 'farmergreg/vim-lastplace'
" Plugin 'groenewege/vim-less'
" Plugin 'tpope/vim-markdown'
" Plugin 'terryma/vim-multiple-cursors'
" Plugin 'Vimjas/vim-python-pep8-indent'
" Plugin 'tpope/vim-repeat'
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
" Plugin 'garbas/vim-snipmate'
" Plugin 'honza/vim-snippets'
" Plugin 'tpope/vim-surround'
" Plugin 'maxbrunsfeld/vim-yankstack'
" Plugin 'amix/vim-zenroom2'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'junkblocker/patchreview-vim'
Plugin 'codegram/vim-codereview'
Plugin 'mikecoder/quickrun.vim'
Plugin 'rhysd/open-pdf.vim'
Plugin 'bazelbuild/vim-bazel'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'
Plugin 'grailbio/bazel-compilation-database'
Plugin 'hushicai/tagbar-javascript.vim'
Plugin 'herringtondarkholme/yats.vim'
Plugin 'heavenshell/vim-pydocstring'
Plugin 'rhysd/rust-doc.vim'
Plugin 'jalcine/cmake.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf'

call vundle#end()            " required
filetype plugin indent on    " required

set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim
source ~/.vim_runtime/my_configs.vim

