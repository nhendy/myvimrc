" set signcolumn=yes
set clipboard=unnamed
set cmdheight=2
set hidden
set mouse=a
set nobackup
set nowritebackup
set nu rnu
set number relativenumber
set relativenumber 
set shell=/bin/zsh
set shortmess+=c
set showcmd
set showmode
set splitbelow
set updatetime=300
set wildmenu
set wildmode=list:longest

inoremap jk <ESC>
inoremap JK <Esc>
inoremap jK <Esc>
inoremap Jk <Esc>
inoremap kj <Esc>
inoremap KJ <Esc>
inoremap Kj <Esc>
inoremap kJ <Esc>

" Arrows are unvimlike 
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0
inoremap <Leader>d <C-o>dd
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
"" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>
if executable('gcc')
  let s:expr = 'gcc -Wp,-v -x c++ - -fsyntax-only 2>&1 | grep "^ " | sed "s/^ //"'
  let s:lines = systemlist(s:expr)
  for s:line in s:lines
    execute 'set path+=' . fnameescape(s:line)
  endfor
endif
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
let g:fzf_mru_relative = 1

 " NOTE: This is important for being able to exit terminal mode
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    au TermOpen  * setlocal nonumber | stopinsert
    au TermClose * setlocal   number | call feedkeys("\<C-\>\<C-n>")
endif

function! QuickRunWithArgs(args1)
  let file_type = expand("%:e")
  if has_key(g:quickrun_known_file_types, file_type)
      let qr_command = join(g:quickrun_known_file_types[file_type], '&&')
      echom a:args1
      execute qr_command . " " . a:args1
  endif
endfunction
let g:doge_doc_standard_python = 'numpy'

" set path=$PWD/**
" set path+=$PATH
" let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let s:molokai_original = 1
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" command! -bang -nargs=? FZFMru call fzf_mru#actions#mru(<q-args>,
"     \{
"         \'window': {'width': 0.9, 'height': 0.8},
"         \'options': [
"             \'--preview', 'cat {}',
"         \]
"     \}
" \)
" let g:ycm_collect_identifiers_from_tags_files=1
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
" let g:ycm_collect_identifiers_from_tags_files = 1
" let g:ycm_enable_diagnostic_signs = 0
" let g:ycm_enable_diagnostic_highlighting = 0
" let g:clang_format_executable="~/centos/usr/bin/clang-format"
let g:go_version_warning = 0
let g:auto_save = 1

let g:coc_root_patterns = ['.git', '.env']
let g:move_map_keys =1
let g:move_auto_indent=1
let g:move_key_modifier='S'
let g:ale_lint_on_enter = 0 
let g:ale_lint_on_text_changed = 'never' 
let g:ale_lint_on_save = 0
let g:ale_set_highlights = 0
let g:python3_host_prog = '/usr/local/bin/python3.10'
nnoremap vv :vsplit<CR>
nnoremap vs :split<CR>
" nmap <leader>sa :ALEFix<CR>
" nmap <leader>ss :ALELint<CR>
autocmd Filetype tex setl updatetime=0.1
let g:livepreview_previewer = 'open -a Preview'

augroup autoformat_settings
  autocmd FileType bzl let b:codefmt_formatter = 'buildifier'
  autocmd FileType python let b:codefmt_formatter = 'black' 
augroup END
" set statusline+=%{gutentags#statusline()}
"let g:gutentags_define_advanced_commands = 1
"" enable gtags module
" let g:gutentags_modules = ['ctags']
""
" config project root markers.
" let g:gutentags_project_root = ['.root', '.git']
 " let g:gutentags_generate_on_missing=1
 " let g:gutentags_generate_on_new=1
""
""" generate datebases in my cache directory, prevent gtags files polluting my project
"let g:gutentags_cache_dir = expand('~/.cache/tags')

"" change focus to quickfix window after search (optional).
"let g:gutentags_plus_switch = 1
"
" let g:tagbar_type_typescript = {
"   \ 'ctagstype': 'typescript',
"   \ 'kinds': [
"     \ 'c:classes',
"     \ 'n:modules',
"     \ 'f:functions',
"     \ 'v:variables',
"     \ 'v:varlambdas',
"     \ 'm:members',
"     \ 'i:interfaces',
"     \ 'e:enums',
"   \ ]
" \ }
" nnoremap yl :YcmCompleter GoToDeclaration<CR>
" nnoremap yf :YcmCompleter GoToDefinition<CR>
" nnoremap yg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>c :FormatCode<CR> 
nmap <leader>t :TagbarToggle<CR>
nnoremap <leader>gb :<C-u>call gitblame#echo()<CR>

" Create a function to reload vimrc. Checks if it already exists to avoid
" redefining the function during the function call.
nmap <leader>gh :call SwitchSourceHeader()<CR>
" function! SourceVimrc()
"     so ~/.vim_runtime/my_configs.vim
" endfunction
 " command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))

" function ClangFormatFile()
"  let l:lines="all"
"  pyf ~/clang-format.py
" endfunction
 nnoremap <leader>c :FormatCode<cr>
 " nnoremap <leader>c :call ClangFormatFile()<cr>

" nnoremap <leader>. :call SourceVimrc()<cr>

" nnoremap <Leader>s :%s/\<<C-r><C-w>\>/



let g:rust_doc#define_map_K=0
let g:rust_doc#downloaded_rust_doc_dir = '~/Development/rust-1.0.0-i686-unknown-linux-gnu/rust-docs'

let g:pydocstring_formatter = 'google'
nmap <silent> <C-_> <Plug>(pydocstring)

" Mapping selecting mappings
 nmap <leader><tab> <plug>(fzf-maps-n)
 xmap <leader><tab> <plug>(fzf-maps-x)
 omap <leader><tab> <plug>(fzf-maps-o)

 " Insert mode completion
 imap <c-x><c-k> <plug>(fzf-complete-word)
 imap <c-x><c-p> <plug>(fzf-complete-path)
 imap <c-x><c-l> <plug>(fzf-complete-line)"


if has("autocmd")
  augroup templates
    autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
    autocmd BufNewFile *.cpp 0r ~/.vim/templates/skeleton.cpp
    autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
    autocmd BufNewFile *_leetcode.cpp 0r ~/.vim/templates/skeleton_leetcode.cpp
  augroup END
endif

function! GotoProtoDef()
:  let l:fname=expand('<cfile>')
:  let l:fname = substitute(l:fname, ".pb.h", ".proto", "")
:  execute 'edit' l:fname
endfunction
nnoremap tp :call GotoProtoDef()<CR>
" nnoremap ~ :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>
" noremap <Leader>a :Ack <cword><cr>
noremap <Leader>a :Ag <C-R><C-W><CR>
noremap <Leader>s :Tags <C-R><C-W><CR>
noremap <Leader>ss :tselect <C-R><C-W><CR>

function! SwitchSourceHeader()
 " Get the current file extension. To see what this command is doing,
 " see :help expand.
 let l:cur_ext=expand("%:e")
 " See if we have a source file (ending in .cpp or .cc).
 if (expand ("%:e") == "cpp" || expand ("%:e") == "cc")
   " %:t gives the basename with extension, :r trims the extension.
   " Try searching for both .h and .hpp extensions, and open the first file
   " that is found.
   let l:h_path=expand("%:r") . ".h"
   let l:hpp_path=expand("%:r") . ".hpp"
   if filereadable(h_path)
     find %:t:r.h
   elseif filereadable(hpp_path)
     find %:t:r.hpp
   endif
 else
   let l:cpp_path=expand("%:r") . ".cpp"
   let l:cc_path=expand("%:r") . ".cc"
   if filereadable(cpp_path)
     find %:t:r.cpp
   elseif filereadable(cc_path)
     find %:t:r.cc
   endif
 endif
endfunction


function! UpdateDeps()
  let l:fname=expand('%:p')
  py3f /mnt/flashblade/carden/utils/update_deps_vim.py
  call input('Press any key to continue')
  redraw!
  execute 'edit' l:fname
endfunction
nnoremap ,u :call UpdateDeps()<cr>


function! GoToBuild()
python3 << EOF
import vim
import os.path

def look_above(filepath):
 dirpath, _, basename = fn.rpartition('/')
 buildfile = os.path.join(dirpath, 'BUILD')
 return os.path.exists(buildfile), buildfile, dirpath

try:
 fn = vim.current.buffer.name
 _, _, basename = fn.rpartition('/')
 while fn:
   exists, buildfile, fn = look_above(fn)
   if exists:
     print("found!!!",buildfile)
     vim.command('edit ' + buildfile)
     vim.command('call search("\\"' + basename + '\\"")')
     break
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction
nnoremap gd :call GoToBuild()<cr>

function! ExecuteBazel()
python3 << EOF
import vim
import os.path
import re
import subprocess
try:
 fn = vim.current.buffer.name
 basename = os.path.basename(fn)
 basename, _ = os.path.splitext(basename)
 dirname = os.path.dirname(fn)
 res = subprocess.check_output(["bazel", "info", "workspace"]).decode()
 target = "{prefix}:{binary}".format(prefix=re.sub(res.strip(), "/", dirname), binary=basename)
 vim.command('vert terminal bazel run {}'.format(target))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! Run()
python3 << EOF
import vim
import os.path

def look_above(filepath):
 dirpath, _, basename = fn.rpartition('/')
 buildfile = os.path.join(dirpath, 'BUILD')
 return os.path.exists(buildfile), buildfile, dirpath

try:
 fn = vim.current.buffer.name
 _, _, basename = fn.rpartition('/')
 ran = False
 while fn:
   exists, buildfile, fn = look_above(fn)
   print(buildfile)
   if exists:
     print("found {}!!!".format(buildfile))
     # vim.command('call ExecuteBazel()')
     vim.command("vsplit")
     vim.command('terminal bazel run {}'.format(target))
     ran = True
     break
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

" nnoremap <leader>r :call ExecuteBazel()<cr>
" nnoremap <leader>r :call Run()<cr>
nnoremap <leader>r :call QuickRun()<cr>

set gfn=Monaco:h13
