  
set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
" Plugin 'valloric/youcompleteme'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'majutsushi/tagbar'
Plugin 'zivyangll/git-blame.vim'
 Plugin 'dense-analysis/ale'
Plugin 'tpope/vim-rhubarb'
 Plugin 'wvffle/vimterm'
 Plugin 'itchyny/lightline.vim'
 " Plugin 'neovim/nvim-lspconfig'
 " Plugin 'hrsh7th/nvim-compe' 
" Plugin 'prabirshrestha/async.vim'
" Plugin 'prabirshrestha/asyncomplete.vim'
" Plugin 'prabirshrestha/asyncomplete-lsp.vim'
" Plugin 'prabirshrestha/vim-lsp'
" Plugin 'mattn/vim-lsp-settings'
" Plugin 'scrooloose/syntastic'
Plugin 'matze/vim-move'
Plugin 'ludovicchabant/vim-gutentags'
" Plugin 'shougo/deoplete.nvim'
 " Plugin 'skywind3000/gutentags_plus'
" Plugin 'craigemery/vim-autotag'
Plugin '907th/vim-auto-save'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'roxma/nvim-yarp'
Plugin 'neoclide/coc.nvim'
Plugin 'jiangmiao/auto-pairs'
"" Also add Glaive, which is used to configure codefmt's maktaba flags. See
"" " `:help :Glaive` for usage.
 Plugin 'google/vim-glaive'
Plugin 'farmergreg/vim-lastplace'
 Plugin 'mileszs/ack.vim'
 Plugin 'kien/ctrlp.vim'
 Plugin 'mru.vim'
 Plugin 'jlanzarotta/bufexplorer'
 Plugin 'chr4/nginx.vim'
 Plugin 'amix/open_file_under_cursor.vim'
 Plugin 'tpope/vim-commentary'
" Plugin 'terryma/vim-expand-region'
" Plugin 'nvie/vim-flake8'
Plugin 'tpope/vim-fugitive'
Plugin  'tell-k/vim-autoflake'

Plugin 'scrooloose/nerdtree'
" 
Plugin 'airblade/vim-gitgutter'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'pangloss/vim-javascript'
Plugin 'groenewege/vim-less'
Plugin 'tpope/vim-markdown'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'tpope/vim-repeat'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-surround'
Plugin 'maxbrunsfeld/vim-yankstack'
Plugin 'amix/vim-zenroom2'
Plugin 'kabouzeid/nvim-lspinstall'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

call vundle#end()            " required
filetype plugin indent on    " required

 set runtimepath+=~/.vim_runtime

 source ~/.vim_runtime/vimrcs/basic.vim
 source ~/.vim_runtime/vimrcs/filetypes.vim
 source ~/.vim_runtime/vimrcs/plugins_config.vim
  source ~/.vim_runtime/vimrcs/extended.vim
 source ~/.vim_runtime/my_configs.vim
