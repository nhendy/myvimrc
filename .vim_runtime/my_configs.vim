" set clipboard+=unnamed
" set clipboard+=unnamedplus
set cmdheight=2
set hidden
set mouse=n
" set ttymouse=xterm2
set nobackup
set nowritebackup
set nu rnu
set number relativenumber
set relativenumber 
set shell=/bin/bash
set shortmess+=c
set showcmd
set showmode
set signcolumn=yes
set splitbelow
set updatetime=1000
set wildmenu
" set colorcolumn=80

set wildmode=list:longest
set autoread

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
noremap <leader>cp :let @" = expand("%")<cr>

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
let g:github_enterprise_urls = ['https://git.zooxlabs.com']
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
autocmd FileType json,hjson setlocal commentstring=//\ %s
" set path=$PWD/**
" set path+=$PATH
let g:ycm_global_ycm_extra_conf='~/ycm_extra_conf.py'
let g:ycm_log_level = 'debug'
let g:ycm_server_log_level = 'debug'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '!'
let g:loaded_node_provider = 0
let g:fzf_mru_relative = 1

let g:vim_markdown_folding_disabled = 1
" let g:loaded_youcompleteme = 1
let g:deoplete#enable_at_startup = 1
let s:molokai_original = 1
let g:rehash256 = 0
" let g:ycm_collect_identifiers_from_tags_files=1
" let g:ycm_enable_diagnostic_signs = 0
" let g:ycm_enable_diagnostic_highlighting = 0
" let g:clang_format_executable="clang-format-3.6"
let g:clang_format_executable="ci/file_validators/bin/clang-format"
let g:doge_comment_interactive=0
let NERDTreeShowBookmarks = 1
let g:cpp_experimental_simple_template_highlight = 0
let g:go_version_warning = 0
let g:auto_save = 1
let g:move_map_keys =1
let g:move_auto_indent=1
let g:pydocstring_doq_path='/usr/local/bin/doq'
let g:pydocstring_formatter = 'google'
" let g:fzf_layout = { 'down': '50%' }
let g:move_key_modifier='S'
let g:python_highlight_all = 1
let g:gutentags_define_advanced_commands=1
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ '--languages=C,C++,CUDA',
      \ ]
let g:gutentags_ctags_exclude = [
      \ 'third_party/*',
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ 'build',
      \ 'bazel*',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ '*.ts', '*.js', 
      \ '*.py', 
      \ ]
" let g:ale_lint_on_enter = 0 
" let g:ale_lint_on_text_changed = 'never' 
" let g:ale_lint_on_save = 0
let g:ale_set_highlights = 1
" 
nmap <leader>sa :ALEFix<CR>
" nmap <leader>ss :ALELint<CR>
" let g:lsp_highlights_enabled = 0
" let g:lsp_textprop_enabled = 0
" let g:lsp_signs_enabled = 0     
" let g:lsp_diagnostics_echo_cursor = 0
set statusline+=%{gutentags#statusline()}
autocmd Filetype tex setl updatetime=0.1
let g:livepreview_previewer = 'open -a Preview'
"let g:gutentags_define_advanced_commands = 1
"" enable gtags module
let g:gutentags_modules = ['ctags']
""
" config project root markers.
" let g:gutentags_project_root = ['.root', '.git']
 " let g:gutentags_generate_on_missing=1
 " let g:gutentags_generate_on_new=1
""
let g:gutentags_generate_on_write = 1
""" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:tags = expand('~/.cache/tags')
let g:doge_enable_mappings=0 
let g:doge_mapping='<leader>`'
let g:doge_doc_standard_cpp = 'doxygen_javadoc'
let g:doge_doc_standard_python = 'google'
autocmd FileType python let b:codefmt_formatter = 'black'
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
" noremap yf :YcmCompleter GoToDefinition<CR>
" nnoremap yg :YcmCompleter GoToDefinitionElseDeclaration<CR>
" nnoremap yg :YcmCompleter GoTo<CR>
" nnoremap <leader>c :FormatCode<CR> 
nmap <leader>t :TagbarToggle<CR>
nnoremap <leader>gb :<C-u>call gitblame#echo()<CR>
 " map <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
 " nmap <silent> gi <Plug>(coc-implementation)
 " nmap <silent> gr <Plug>(coc-references)
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>
nnoremap gdh :diffget //2<cr>
let g:ycm_filepath_blacklist = {
      \ 'html': 1,
      \ 'proto': 1,
      \ 'jsx': 1,
      \ 'xml': 1,
      \}
" nnoremap <leader>c :call Zfix()<CR> 
nnoremap <leader>c :FormatCode<CR> 
" let g:coc_node_path="/home/nhendy/node-v14.17.1-linux-x64/bin/node"
let g:coc_node_path="/home/nhendy/.nvm/versions/node/v16.17.0/bin/node"

" Create a function to reload vimrc. Checks if it already exists to avoid
" redefining the function during the function call.
" function! SourceVimrc()
"     so ~/.vim_runtime/my_configs.vim
" endfunction
 " command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))

" function ClangFormatFile()
"  let l:lines="all"
"  pyf ~/clang-format.py
" endfunction
 command! -range=% Isort :<line1>,<line2>! isort -
 " nnoremap <leader>c :call ClangFormatFile()<cr>

" nnoremap <leader>. :call SourceVimrc()<cr>

" nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
nnoremap vv :vsplit<CR>
nnoremap vs :split<CR>

autocmd FileType python let b:codefmt_formatter = 'black'
let g:autoflake_remove_all_unused_imports=1
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
 imap <c-x><c-l> <plug>(fzf-complete-line)


if has("autocmd")
  augroup templates
    autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
    autocmd BufNewFile *.cpp 0r ~/.vim/templates/skeleton.cpp
    autocmd BufNewFile *_leetcode.cpp 0r ~/.vim/templates/skeleton_leetcode.cpp
  augroup END
  augroup ALEControl
      autocmd!
      autocmd FileType * ALEDisable
      autocmd FileType python ALEEnable
  augroup END
endif

function! GotoProtoDef()
:  let l:fname=expand('<cfile>')
:  let l:fname = substitute(l:fname, ".pb.h", ".proto", "")
:  let l:fname = substitute(l:fname, ".hpp", ".proto", "")
:  execute 'edit' l:fname
endfunction
function! GotoProtoHeader()
:  let l:fname=expand('<cfile>')
:  let l:fname = "bazel-bin/" . l:fname
:  execute 'edit' l:fname
endfunction
nnoremap tp :call GotoProtoDef()<CR>
nnoremap th :call GotoProtoHeader()<CR>
" nnoremap ~ :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>
" noremap <Leader>a :Ack <cword><cr>
noremap <Leader>a :Ag <C-R><C-W><CR>
noremap <Leader>s :Tags <C-R><C-W><CR>
noremap <Leader>ss :ts <C-R><C-W><CR>
augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END

function! SwitchSourceHeader()
 " Get the current file extension. To see what this command is doing,
 " see :help expand.
 let l:cur_ext=expand("%:e")
 " See if we have a source file (ending in .cpp or .cc).
 if (expand ("%:e") == "cpp" || expand ("%:e") == "cc" || expand("%:r:e") == "cu" )
   " %:t gives the basename with extension, :r trims the extension.
   " Try searching for both .h and .hpp extensions, and open the first file
   " that is found.
   let l:h_path=expand("%:r") . ".h"
   let l:hpp_path=expand("%:r") . ".hpp"
   let l:hcu_path=expand("%:r:r") . ".h"
   if filereadable(h_path)
     find %:t:r.h
   elseif filereadable(hpp_path)
     find %:t:r.hpp
   elseif filereadable(hcu_path)
     find %:t:r:r.h
   endif
 else
   let l:cpp_path=expand("%:r") . ".cpp"
   let l:cc_path=expand("%:r") . ".cc"
   let l:cu_path=expand("%:r") . ".cu.cpp"
   if filereadable(cpp_path)
     find %:t:r.cpp
   elseif filereadable(cc_path)
     find %:t:r.cc
   elseif filereadable(cu_path)
     find %:t:r.cu.cpp
   endif
 endif
endfunction


function! UpdateDeps()
  let l:fname=expand('%:p')
  py3f /home/nhendy/update_deps_vim.py
  call input('Press any key to continue')
  redraw!
  execute 'edit' l:fname
endfunction

function! UpdateDb()
python3 << EOF
import vim
import os.path
import re
import subprocess
try:
 fn = vim.current.buffer.name
 dirname = os.path.dirname(fn)
 basename = os.path.basename(fn)
 basename = basename.replace(".cu", "")
 basename , ext = basename.split(".")
 target = "{prefix}/...".format(prefix=re.sub("/home/nhendy/driving[0-9]?", "/", dirname))
 #target = "{prefix}:{binary}".format(prefix=re.sub("/home/nhendy/driving[0-9]?", "/", dirname), binary=basename)
 #cmd = "silent !devx/scripts/setup_cpp_autocomplete.py  {} --config cuda &".format(target)
 cmd = ["devx/scripts/setup_cpp_autocomplete.py", target]
 print("Running {}".format(" ".join(cmd)))
 subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
 vim.command("redraw!")
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! Zfix()
python3 << EOF
import vim
import subprocess
try:
 cmd = ["./ci/file_validators/validate.py", "--changed", "--fix"]
 print("Running {}".format(" ".join(cmd)))
 subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
 vim.command("redraw!")
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction



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

" function! GoToProtoHeader()
" python3 << EOF
" import vim
" import os.path
" import re
" import subprocess
" try:
"  fn = vim.current.buffer.name
"  basename = os.path.basename(fn)
"  # basename, _ = os.path.splitext(basename)
"  dirname = os.path.dirname(fn)
"  target = "{prefix}/{binary}".format(prefix=re.sub("/home/nhendy/driving[0-9]?", "bazel-bin", dirname), binary=basename)
"  print(eval("<cfile>"))
"  #vim.command('edit {}'.format(target))
" except Exception as e:
"   print("Something went wrong: " + str(e))
" EOF
" endfunction
function! ExecuteBazel()
python3 << EOF
import vim
import os.path
import re
import subprocess
try:
 vim.command("call AutoSave()")
 fn = vim.current.buffer.name
 basename = os.path.basename(fn)
 basename = basename.replace(".cu", "")
 basename , ext = basename.split(".")

 dirname = os.path.dirname(fn)
 target = "{prefix}:{binary}".format(prefix=re.sub("/home/nhendy/driving[0-9]?", "/", dirname), binary=basename)
 print(vim.eval("has('nvim')"))
 if int(vim.eval("has('nvim')")) == 1:
     print("hero")
     vim.command("vsplit")
     #vim.command('terminal bazel {} run {}'.format("" if ext == "py" else "--bazelrc=$HOME/.one_cuda.bazelrc", target))
     vim.command('terminal bazel run {}'.format(target))
 else:
     vim.command('vert terminal bazel run {}'.format( target))
     # vim.command('vert terminal bazel {} run {}'.format("" if ext == "py" else "--bazelrc=$HOME/.one_cuda.bazelrc" , target))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! ExecuteScenarioSim(sim_args)
python3 << EOF
import vim
import os.path
import re
import subprocess
try:
 vim.command("call AutoSave()")
 fn = vim.current.buffer.name
 basename = os.path.basename(fn)
 basename = basename.replace(".cu", "")
 basename , ext = basename.split(".")

 dirname = os.path.dirname(fn)
 target = "{prefix}:{binary}".format(prefix=re.sub("/home/nhendy/driving[0-9]?", "/", dirname), binary=basename)
 if int(vim.eval("has('nvim')")) == 1:
     print("hero")
     vim.command("vsplit")
     vim.command("terminal sim/launch.sh local planner {}  --simulator_args='--params-kv planner/config_variant_id=decision3_uap --mission_config_mode_override=DECISION3_UAP {}' --param_filters='__name__={}' --save_chum_nfs --bazel_args='--//base/cuda:cuda_arch=compute_75'".format(target, vim.eval("a:sim_args"), target))
 else:
     vim.command("vert terminal sim/launch.sh local planner {}  --simulator_args='--params-kv planner/config_variant_id=decision3_uap --mission_config_mode_override=DECISION3_UAP {}' --param_filters='__name__={}' --save_chum_nfs --bazel_args='--//base/cuda:cuda_arch=compute_75'".format(target, vim.eval("a:sim_args"), target))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! ExecuteBazelUnderNsys(args)
python3 << EOF
import vim
import os.path
import re
import subprocess
try:
 vim.command("call AutoSave()")
 fn = vim.current.buffer.name
 basename = os.path.basename(fn)
 basename = basename.replace(".cu", "")
 basename , ext = basename.split(".")

 dirname = os.path.dirname(fn)
 target = "{prefix}:{binary}".format(prefix=re.sub("/home/nhendy/driving[0-9]?", "/", dirname), binary=basename)
 print(vim.eval("has('nvim')"))
 if int(vim.eval("has('nvim')")) == 1:
     print("hero")
     vim.command("vsplit")
     #vim.command('terminal bazel {} run {}'.format("" if ext == "py" else "--bazelrc=$HOME/.one_cuda.bazelrc", target))
     vim.command("terminal bazel run --config=cuda_profile --run_under='sudo nsys profile --cuda-memory-usage=true --trace=cuda,cudnn,nvtx -f true --gpu-metrics-device=0 -o /tmp/trace/nsys_result' {} -- {}".format(target, vim.eval("a:args")))
 else:
     vim.command("vert terminal bazel run --config=cuda_profile --run_under='sudo nsys profile --cuda-memory-usage=true --trace=cuda,cudnn,nvtx -f true --gpu-metrics-device=0 -o /tmp/trace/nsys_result' {} -- {}".format( target, vim.eval("a:args")))
     # vim.command('vert terminal bazel {} run {}'.format("" if ext == "py" else "--bazelrc=$HOME/.one_cuda.bazelrc" , target))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! BuildBazel()
python3 << EOF
import vim
import os.path
import re
import subprocess
try:
 vim.command("call AutoSave()")
 fn = vim.current.buffer.name
 basename = os.path.basename(fn)
 basename, _ = os.path.splitext(basename)
 dirname = os.path.dirname(fn)
 target = "{prefix}:{binary}".format(prefix=re.sub("/home/nhendy/driving[0-9]?", "/", dirname), binary=basename.rstrip(".cu"))
 vim.command("split")
 vim.command('terminal source /home/nhendy/.bashrc && bazel build {}'.format(target))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! RunMypy(bazel_args)
python3 << EOF
import vim
import os.path
import re
import subprocess
try:
 vim.command("call AutoSave()")
 fn = vim.current.buffer.name
 basename = os.path.basename(fn)
 basename, _ = os.path.splitext(basename)
 dirname = os.path.dirname(fn)
 target = "{prefix}:{binary}_mypy_test".format(prefix=re.sub("/home/nhendy/driving[0-9]?", "/", dirname), binary=basename)
 vim.command("split")
 vim.command('terminal source /home/nhendy/.bashrc && bazel run {} {}'.format(vim.eval("a:bazel_args"), target))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! ExecuteBazelArgs(bazel_args, args)
python3 << EOF
import vim
import os.path
import re
import subprocess
try:
 vim.command("call AutoSave()")
 fn = vim.current.buffer.name
 basename = os.path.basename(fn)
 print (f"Here {basename}")
 basename = basename.replace(".cu", "")
 basename, ext = basename.split(".")
 print("here2")
 dirname = os.path.dirname(fn)
 target = "{prefix}:{binary}".format(prefix=re.sub("/home/nhendy/driving[0-9]?", "/", dirname), binary=basename)
 vim.command("vsplit")
 vim.command('term bazel run {} {} -- {}'.format(vim.eval("a:bazel_args"), target, vim.eval("a:args")))
 # vim.command('term bazel {} run {} -- {}'.format("" if ext == "py" else "--bazelrc=$HOME/.one_cuda.bazelrc", target, vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! RunPredResearch(args)
python3 << EOF
import vim
import os.path
import re
import subprocess
try:
 vim.command("call AutoSave()")
 fn = vim.current.buffer.name
 vim.command("vsplit")
 vim.command("term  PRED_RESEARCH_DRIVING_ROOT='~/driving' python -m {} {}".format(os.path.relpath(os.path.splitext(fn)[0], os.getcwd()).replace("/", "."), vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! RunStreamlit(args)
python3 << EOF
import vim
import os.path
import re
import subprocess
try:
 vim.command("call AutoSave()")
 fn = vim.current.buffer.name
 vim.command("vsplit")
 vim.command('term  python -m streamlit run {} {}'.format(os.path.relpath(fn, os.getcwd()), vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! TrainPredResearch(args)
python3 << EOF
import vim
import os.path
import re
import subprocess
try:
 vim.command("call AutoSave()")
 vim.command("vsplit")
 vim.command('term  python -m common.train {}'.format(vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction


function! TrainPredResearchPd(args)
python3 << EOF
import vim
import os.path
import re
import subprocess
try:
 vim.command("call AutoSave()")
 vim.command("vsplit")
 vim.command("term  PRED_RESEARCH_DRIVING_ROOT='~/driving' python -m common.launch_job {}".format(vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! ExecuteBazelDebug(bazel_args, args)
python3 << EOF
import vim
import os.path
import re
import subprocess
try:
 vim.command("call AutoSave()")
 fn = vim.current.buffer.name
 basename = os.path.basename(fn)
 basename, _ = os.path.splitext(basename)
 dirname = os.path.dirname(fn)
 target = "{prefix}:{binary}".format(prefix=re.sub("/home/nhendy/driving[0-9]?", "/", dirname), binary=basename)
 vim.command("vsplit")
 vim.command('term {}/devx/scripts/debug.py {}  {} '.format(os.getcwd(), vim.eval("a:bazel_args"), target))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! PipedreamExecuteBazelArgs(pipeargs, args)
python3 << EOF
import vim
import os.path
import re
import subprocess
 fn = vim.current.buffer.name
try:
 vim.command("call AutoSave()")
 basename = os.path.basename(fn)
 basename, _ = os.path.splitext(basename)
 dirname = os.path.dirname(fn)
 target = "{prefix}:{binary}".format(prefix=re.sub("/home/nhendy/driving[0-9]?", "/", dirname), binary=basename)
 vim.command("vsplit")
 vim.command('term source {}/scripts/shell/zooxrc.sh && pipedream/tools/run bazel --docker_args="--runtime=nvidia" --gpus 0 --slack_targets @nhendy --name {} {} {} -- {}'.format(os.getcwd(), basename, vim.eval("a:pipeargs"), target, vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! RunSafetyNet()
python3 << EOF
import vim
try:
 vim.command("call AutoSave()")
 target = "//vehicle/perception/learning/safetynet:run_safetynet"
 if vim.eval("has('nvim')") == 1:
     vim.command("vsplit")
     vim.command("term")
     vim.command('term bazel run {}'.format(target))
 else:
    vim.command('vert term bazel run {}'.format(target))

except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! RunSim2dPlayback(sim_args, args)
python3 << EOF
import vim
import uuid
try:
 vim.command("call AutoSave()")
 if int(vim.eval("has('nvim')")) == 1:

     vim.command("vsplit")
     vim.command("term")
     #vim.command("term ZOOX_MEMORY_REPORT_FN=/tmp/trace/memory.pbtxt sim/launch.sh local planner {}  --simulator_args='--params-kv sim/override_autonomous_mode=PURE_PLAYBACK_AFTER_INIT_MODE --params-kv planner/config_variant_id=decision3_uap {}' --save_chum_nfs  --bazel_args='--//base/cuda:cuda_arch=compute_75' --trace_output=/tmp/trace/{} --zoox_tracer_enable --zoox_enable_cuda_tracing".format(vim.eval("a:args"), vim.eval("a:sim_args"), uuid.uuid4()))
     #vim.command("term /home/nhendy/driving2/bazel-driving2/external/cuda_repo/cuda/bin/compute-sanitizer --target-processes all --tool memcheck --launch-timeout 0 sim/launch.sh local planner {}  --simulator_args='--params-kv sim/override_autonomous_mode=PURE_PLAYBACK_AFTER_INIT_MODE --params-kv planner/config_variant_id=decision3_uap {}' --save_chum_nfs  --bazel_args='--//base/cuda:cuda_arch=compute_75'".format(vim.eval("a:args"), vim.eval("a:sim_args"), uuid.uuid4()))
     vim.command("term sim/launch.sh local planner {}  --simulator_args='--params-kv sim/override_autonomous_mode=PURE_PLAYBACK_AFTER_INIT_MODE --params-kv planner/config_variant_id=decision3_uap --mission_config_mode_override=DECISION3_UAP {}' --save_chum_nfs  --bazel_args='--//base/cuda:cuda_arch=compute_75'".format(vim.eval("a:args"), vim.eval("a:sim_args")))
 else:
     #vim.command("vert term ZOOX_MEMORY_REPORT_FN=/tmp/trace/memory.pbtxt sim/launch.sh local planner {}  --simulator_args='--params-kv sim/override_autonomous_mode=PURE_PLAYBACK_AFTER_INIT_MODE --params-kv planner/config_variant_id=decision3_uap {}' --save_chum_nfs  --bazel_args='--//base/cuda:cuda_arch=compute_75'--trace_output=/tmp/trace/{} --zoox_tracer_enable --zoox_enable_cuda_tracing".format(vim.eval("a:args"), vim.eval("a:sim_args"),  uuid.uuid4()))
     #vim.command("vert term /home/nhendy/driving2/bazel-driving2/external/cuda_repo/cuda/bin/compute-sanitizer --target-processes all --tool memcheck --destroy-on-device-error kernel --launch-timeout 0 sim/launch.sh local planner {}  --simulator_args='--params-kv sim/override_autonomous_mode=PURE_PLAYBACK_AFTER_INIT_MODE --params-kv planner/config_variant_id=decision3_uap {}' --save_chum_nfs  --bazel_args='--//base/cuda:cuda_arch=compute_75'".format(vim.eval("a:args"), vim.eval("a:sim_args"),  uuid.uuid4()))
     vim.command("vert term  sim/launch.sh local planner {}  --simulator_args='--params-kv sim/override_autonomous_mode=PURE_PLAYBACK_AFTER_INIT_MODE --params-kv planner/config_variant_id=decision3_uap --mission_config_mode_override=DECISION3_UAP {}' --save_chum  --bazel_args='--//base/cuda:cuda_arch=compute_75'".format(vim.eval("a:args"), vim.eval("a:sim_args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! RunSim2d(sim_args, args)
python3 << EOF
import vim
import uuid
try:
 vim.command("call AutoSave()")
 if int(vim.eval("has('nvim')")) == 1:

     vim.command("vsplit")
     # vim.command("term")
     #vim.command("term ZOOX_MEMORY_REPORT_FN=/tmp/trace/memory.pbtxt sim/launch.sh local planner {}  --simulator_args='--params-kv sim/override_autonomous_mode=PURE_PLAYBACK_AFTER_INIT_MODE --params-kv planner/config_variant_id=decision3_uap {}' --save_chum_nfs  --bazel_args='--//base/cuda:cuda_arch=compute_75' --trace_output=/tmp/trace/{} --zoox_tracer_enable --zoox_enable_cuda_tracing".format(vim.eval("a:args"), vim.eval("a:sim_args"), uuid.uuid4()))
     #print(vim.eval("a:args"))
     vim.command("term  sim/launch.sh local planner \'{}\' --simulator_args='--params-kv planner/config_variant_id=decision3_uap --mission_config_mode_override=DECISION3_UAP {}' --save_chum_nfs  --bazel_args='--//base/cuda:cuda_arch=compute_75'".format(vim.eval("a:args"), vim.eval("a:sim_args"), uuid.uuid4()))
 else:
     #vim.command("vert term ZOOX_MEMORY_REPORT_FN=/tmp/trace/memory.pbtxt sim/launch.sh local planner {}  --simulator_args='--params-kv sim/override_autonomous_mode=PURE_PLAYBACK_AFTER_INIT_MODE --params-kv planner/config_variant_id=decision3_uap {}' --save_chum_nfs  --bazel_args='--//base/cuda:cuda_arch=compute_75'--trace_output=/tmp/trace/{} --zoox_tracer_enable --zoox_enable_cuda_tracing".format(vim.eval("a:args"), vim.eval("a:sim_args"),  uuid.uuid4()))
     vim.command("vert term  sim/launch.sh local planner {}  --simulator_args='--params-kv planner/config_variant_id=decision3_uap --mission_config_mode_override=DECISION3_UAP {}' --save_chum --bazel_args='--//base/cuda:cuda_arch=compute_75'".format(vim.eval("a:args"), vim.eval("a:sim_args"),  uuid.uuid4()))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! RerunCase(args)
python3 << EOF
import vim
import uuid
try:
 vim.command("call AutoSave()")
 if int(vim.eval("has('nvim')")) == 1:

     vim.command("vsplit")
     vim.command("term")
     #vim.command("term sim/launch.sh local use_chum chum://20230120T223251-kitt_103@1674255090-1674255110 --param_filters='__name__=20230120T223251-kitt_103-1674255090.0-1674255110.0' --use_chum_uri='chum://20230120T223251-kitt_103@1674255090-1674255110?i=$vars,$empty,$default&v=logtests/CompileScenarioModule/b7fcc93cb9b6b601871cec5d9bbeab99834245c7ed9537310c11bc3201f04d93_236a6664a0db11ed8c5d0242c0a80006,logtests/CreateScenarioModule/8c4d12be923070b2c19baf8d6c3361104190314d6832fcc392bea21d344e26fe_1ebfc370a0db11ed8c5d0242c0a80006' --save_chum_nfs --simulator_args=\"--params-kv sim/metrics=true --params-kv planner/config_variant_id=decision3_uap --params-kv scenario_override/options/monitors/validate_dispatch_waypoints=false --params-kv sim/terminate_on=none --mission_config_mode_override=INTERNAL\"  ".format(vim.eval("a:args")))
     #vim.command("term sim/launch.sh local use_chum chum://20230120T223251-kitt_103@1674255093.99+20s --param_filters='__name__=20230120T223251-kitt_103-1674255093.99-1674255113.99' --use_chum_uri='chum://20230120T223251-kitt_103@1674255093.99-1674255113.99?i=$vars,$empty,$default&v=logtests/CompileScenarioModule/c18b90c55b79a3f51b0db2434c78ab0de6f54627570b8ef3345e0674d0c83ed2_a56a585aa0da11ed99e90242c0a80004,logtests/CreateScenarioModule/076019d769120e44207f2b1ee78ffdd2bb1e5368be8efbc1bff902d92f514ac6_9dd67998a0da11ed99e90242c0a80004' --save_chum_nfs --simulator_args=\"--params-kv planner/config_variant_id=decision3_uap --params-kv scenario_override/options/monitors/validate_dispatch_waypoints=false --params-kv sim/terminate_on=none --mission_config_mode_override=INTERNAL\" ".format(vim.eval("a:args")))
     # vim.command("term sim/launch.sh local planner //sim/sim_tests/test_suites/decision_3_sim_tests/lateral_maneuvers/blockage_handling/pio_dpv:C412680_stopped_dpv_on_two_double_yellow_lane_agent_oncoming --param_filters='CAR_2_position=3 __name__=//sim/sim_tests/test_suites/decision_3_sim_tests/lateral_maneuvers/blockage_handling/pio_dpv:C412680_stopped_dpv_on_two_double_yellow_lane_agent_oncoming hero_vehicle_type=1' --save_chum_nfs --simulator_args=\"--params-kv sim/metrics=true --params-kv planner/config_variant_id=decision3_uap\" --bazel_args='--//base/cuda:cuda_arch=compute_75'".format(vim.eval("a:args")))
     # vim.command("term sim/launch.sh local planner '/mnt/sun-tcs01/planner/shared/autotune/temp/0bc44e46-c521-41a9-961e-7e6dd473ccc2/C401438_Agent_in_heros_lane_does_a_k-turn_ahead_of_hero/Region_Trigger_position=1_hero_vehicle_type=1_scenario.pbtxt' --simulator_args=\"--params-kv sim/terminate_on=passed,COLLISION_MONITOR --params-kv scenario_override/options/monitors/avoid_collisions_assertion/check_recorded_hero=false --params-kv scenario_override/options/monitors/avoid_collisions_assertion/use_hero_polygon=true --params-kv scenario_override/options/monitors/avoid_collisions_assertion/check_steam_exhaust=false --params-kv scenario_override/options/monitors/avoid_collisions_assertion/longitudinal_hero_contour_expansion=0 --params-kv scenario_override/options/monitors/avoid_collisions_assertion/lateral_hero_contour_expansion=0 --params-kv scenario_override/options/monitors/avoid_collisions_assertion/speed_dependent_hero_contour_expansion=false --params-kv scenario_override/options/monitors/avoid_collisions_assertion/max_nogo_hero_contour_expansion=false --params-kv sim/enable_monitors=true --params-kv planner/config_variant_id=decision3_uap --mission_config_mode_override=DECISION3_UAP --logtostderr\" --bazel_args='--//base/cuda:cuda_arch=compute_75' --save_chum_nfs".format(vim.eval("a:args")))
     vim.command("term sim/launch.sh local planner //sim/sim_tests/test_suites/decision_3_sim_tests/junctions/fifo_junction/fifo_junctions_baseline:C153948_hero_at_4ws_turns_right --param_filters='__name__=//sim/sim_tests/test_suites/decision_3_sim_tests/junctions/fifo_junction/fifo_junctions_baseline:C153948_hero_at_4ws_turns_right hero_vehicle_type=0' --save_chum --simulator_args=\"--params-kv sim/metrics=true --params-kv planner/config_variant_id=decision3_uap\" --bazel_args='--//base/cuda:cuda_arch=compute_75' ".format(vim.eval("a:args")))
 else:
     # vim.command("vert term sim/launch.sh local use_chum chum://20230120T223251-kitt_103@1674255090-1674255110 --param_filters='__name__=20230120T223251-kitt_103-1674255090.0-1674255110.0' --use_chum_uri='chum://20230120T223251-kitt_103@1674255090-1674255110?i=$vars,$empty,$default&v=logtests/CompileScenarioModule/b7fcc93cb9b6b601871cec5d9bbeab99834245c7ed9537310c11bc3201f04d93_236a6664a0db11ed8c5d0242c0a80006,logtests/CreateScenarioModule/8c4d12be923070b2c19baf8d6c3361104190314d6832fcc392bea21d344e26fe_1ebfc370a0db11ed8c5d0242c0a80006' --save_chum_nfs --simulator_args=\"--params-kv sim/metrics=true --params-kv planner/config_variant_id=decision3_uap --params-kv scenario_override/options/monitors/validate_dispatch_waypoints=false --params-kv sim/terminate_on=none --mission_config_mode_override=INTERNAL\"  ".format(vim.eval("a:args") ))
     #vim.command("vert term sim/launch.sh local use_chum chum://20230120T223251-kitt_103@1674255093.99+20s --param_filters='__name__=20230120T223251-kitt_103-1674255093.99-1674255113.99' --use_chum_uri='chum://20230120T223251-kitt_103@1674255093.99-1674255113.99?i=$vars,$empty,$default&v=logtests/CompileScenarioModule/c18b90c55b79a3f51b0db2434c78ab0de6f54627570b8ef3345e0674d0c83ed2_a56a585aa0da11ed99e90242c0a80004,logtests/CreateScenarioModule/076019d769120e44207f2b1ee78ffdd2bb1e5368be8efbc1bff902d92f514ac6_9dd67998a0da11ed99e90242c0a80004' --save_chum_nfs --simulator_args=\" --params-kv planner/config_variant_id=decision3_uap --params-kv scenario_override/options/monitors/validate_dispatch_waypoints=false --params-kv sim/terminate_on=none --mission_config_mode_override=INTERNAL\" ".format(vim.eval("a:args")))
     vim.command("term sim/launch.sh local planner //sim/sim_tests/test_suites/decision_3_sim_tests/junctions/fifo_junction/fifo_junctions_baseline:C153948_hero_at_4ws_turns_right --param_filters='__name__=//sim/sim_tests/test_suites/decision_3_sim_tests/junctions/fifo_junction/fifo_junctions_baseline:C153948_hero_at_4ws_turns_right hero_vehicle_type=0' --save_chum_nfs --simulator_args=\"--params-kv sim/metrics=true --params-kv planner/config_variant_id=decision3_uap\" --bazel_args='--//base/cuda:cuda_arch=compute_75' ".format(vim.eval("a:args")))
     # vim.command("term sim/launch.sh local planner '/mnt/sun-tcs01/planner/shared/autotune/temp/0bc44e46-c521-41a9-961e-7e6dd473ccc2/C401438_Agent_in_heros_lane_does_a_k-turn_ahead_of_hero/Region_Trigger_position=1_hero_vehicle_type=1_scenario.pbtxt' --simulator_args=\"--params-kv sim/terminate_on=passed,COLLISION_MONITOR --params-kv scenario_override/options/monitors/avoid_collisions_assertion/check_recorded_hero=false --params-kv scenario_override/options/monitors/avoid_collisions_assertion/use_hero_polygon=true --params-kv scenario_override/options/monitors/avoid_collisions_assertion/check_steam_exhaust=false --params-kv scenario_override/options/monitors/avoid_collisions_assertion/longitudinal_hero_contour_expansion=0 --params-kv scenario_override/options/monitors/avoid_collisions_assertion/lateral_hero_contour_expansion=0 --params-kv scenario_override/options/monitors/avoid_collisions_assertion/speed_dependent_hero_contour_expansion=false --params-kv scenario_override/options/monitors/avoid_collisions_assertion/max_nogo_hero_contour_expansion=false --params-kv sim/enable_monitors=true --params-kv planner/config_variant_id=decision3_uap --mission_config_mode_override=DECISION3_UAP --logtostderr\" --bazel_args='--//base/cuda:cuda_arch=compute_75' --save_chum_nfs".format(vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! RunDecisionPlayer(args)
python3 << EOF
import vim
import uuid
try:
 vim.command("call AutoSave()")
 if int(vim.eval("has('nvim')")) == 1:

     vim.command("vsplit")
     vim.command("term")
     # vim.command("term bazel --bazelrc=$HOME/.one_cuda.bazelrc run  //vehicle/planner/decision3/tools/decision_player:decision_player -- {} --config_variant=decision3_uap".format(vim.eval("a:args")))
     vim.command("term bazel  run  //vehicle/planner/decision3/tools/decision_player:decision_player -- {} --config_variants=decision3_uap".format(vim.eval("a:args")))
 else:
     #vim.command("vert term  bazel --bazelrc=$HOME/.one_cuda.bazelrc run //vehicle/planner/decision3/tools/decision_player:decision_player -- {} --config_variant=decision3_uap".format(vim.eval("a:args")))
     vim.command("vert term  bazel  run //vehicle/planner/decision3/tools/decision_player:decision_player -- {} --config_variants=decision3_uap".format(vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! RunD3Tick(bazel_args, args)
python3 << EOF
import vim
import uuid
try:
 vim.command("call AutoSave()")
 if int(vim.eval("has('nvim')")) == 1:

     vim.command("vsplit")
     vim.command("term")
     # vim.command("term bazel --bazelrc=$HOME/.one_cuda.bazelrc run  //vehicle/planner/decision3/tools/decision_player:decision_player -- {} --config_variant=decision3_uap".format(vim.eval("a:args")))
     vim.command("term bazel  run {} -c opt  //vehicle/planner/decision3/tools/decision_player/scripts:d3_tick_player -- {} --config_variants=decision3_uap".format(vim.eval("a:bazel_args"), vim.eval("a:args")))
 else:
     #vim.command("vert term  bazel --bazelrc=$HOME/.one_cuda.bazelrc run //vehicle/planner/decision3/tools/decision_player:decision_player -- {} --config_variant=decision3_uap".format(vim.eval("a:args")))
     vim.command("vert term  bazel  run -c opt --config=cuda_nsys --config=cuda_profile //vehicle/planner/decision3/tools/decision_player/scripts:d3_tick_player -- {} --config_variants=decision3_uap".format(vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! RunTrtExec(args)
python3 << EOF
import vim
import uuid
try:
 vim.command("call AutoSave()")
 if int(vim.eval("has('nvim')")) == 1:

     vim.command("vsplit")
     vim.command("term")
     # vim.command("term bazel --bazelrc=$HOME/.one_cuda.bazelrc run  //vehicle/planner/decision3/tools/decision_player:decision_player -- {} --config_variant=decision3_uap".format(vim.eval("a:args")))
     vim.command("term bazel run  @tensor_rt_oss//:trtexec -- {} ".format(vim.eval("a:args")))
 else:
     #vim.command("vert term  bazel --bazelrc=$HOME/.one_cuda.bazelrc run //vehicle/planner/decision3/tools/decision_player:decision_player -- {} --config_variant=decision3_uap".format(vim.eval("a:args")))
     vim.command("vert term  bazel run  @tensor_rt_oss//:trtexec  -- {}".format(vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! RunApGenerator(args)
python3 << EOF
import vim
import uuid
try:
 vim.command("call AutoSave()")
 if int(vim.eval("has('nvim')")) == 1:

     vim.command("vsplit")
     vim.command("term")
     vim.command("term bazel  run //mined_metric/builder/metrics_impl/prediction_trajectory_metrics/input_generation:prediction_generator_main -- {} --output_chum_root /mnt/sun-tcs01/pred/users/nhendy/tmp".format(vim.eval("a:args")))
 else:
     vim.command("vert term  bazel  run //mined_metric/builder/metrics_impl/prediction_trajectory_metrics/input_generation:prediction_generator_main -- {} --output_chum_root /mnt/sun-tcs01/pred/users/nhendy/tmp".format(vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! RunSuppGenerator(args)
python3 << EOF
import vim
import uuid
try:
 vim.command("call AutoSave()")
 if int(vim.eval("has('nvim')")) == 1:

     vim.command("vsplit")
     vim.command("term")
     vim.command("term bazel  run --config=mlinfra_v2 //prediction/learning/topdown/train_framework/bin:generate_supplemental_state -- {} --output_root /mnt/sun-tcs01/pred/users/nhendy/tmp".format(vim.eval("a:args")))
 else:
     vim.command("vert term  bazel --bazelrc=$HOME/.mlinfra.bazelrc run //prediction/learning/topdown/train_framework/bin:generate_supplemental_state -- {} --output_root /mnt/sun-tcs01/pred/users/nhendy/tmp".format(vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! RunSim2dDebug(args)
python3 << EOF
import vim
try:
 vim.command("call AutoSave()")
 if int(vim.eval("has('nvim')")) == 1:
     vim.command("vsplit")
     vim.command("term")
     vim.command("term devx/scripts/debug.py --compilation_mode=dbg --cgdb sim/launch.sh local planner {} --simulator_args='--params-kv planner/config_variant_id=decision3_uap' --save_chum_nfs".format(vim.eval("a:args")))
 else:
     vim.command("vert term devx/scripts/debug.py --compilation_mode=dbg --cgdb sim/launch.sh local planner {} --simulator_args='--params-kv planner/config_variant_id=decision3_uap' --save_chum_nfs".format(vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! Train(args)
python3 << EOF
import vim
try:
 target = "//prediction/learning/topdown/train_framework/bin:train"
 vim.command("call AutoSave()")
 if int(vim.eval("has('nvim')")) == 1:
     vim.command("vsplit")
     vim.command('term bazel --bazelrc=$HOME/.mlinfra.bazelrc run {} -- {}'.format(target, vim.eval("a:args")))
 else:
     vim.command('vert term bazel --bazelrc=$HOME/.mlinfra.bazelrc run {} -- {}'.format(target, vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! ScenarioEditorConvert(args)
python3 << EOF
import vim
try:
 target = "//prediction/learning/topdown/scene_generation/zsaf_integration:run"
 vim.command("call AutoSave()")
 if int(vim.eval("has('nvim')")) == 1:
     vim.command("vsplit")
     vim.command('term bazel run --config=mlinfra_v3 {} -- {}'.format(target, vim.eval("a:args")))
 else:
     vim.command('vert term bazel run --config=mlinfra_v3 {} -- {}'.format(target, vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! TrainPip(args)
python3 << EOF
import vim
try:
 target = "//prediction/learning/topdown/train_framework/bin:run_train"
 vim.command("call AutoSave()")
 if int(vim.eval("has('nvim')")) == 1:
     vim.command("vsplit")
     vim.command('term bazel --bazelrc=$HOME/.mlinfra.bazelrc run {} -- {}'.format(target, vim.eval("a:args")))
 else:
     vim.command('vert term bazel --bazelrc=$HOME/.mlinfra.bazelrc run {} -- {}'.format(target, vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! VizEval(args)
python3 << EOF
import vim
try:
 #target = "./mined_metric/builder/metrics_impl/prediction_trajectory_metrics/app/run.sh"
 target = "//mined_metric/builder/metrics_impl/prediction_trajectory_metrics/app"
 vim.command("call AutoSave()")
 if int(vim.eval("has('nvim')")) == 1:
     vim.command("vsplit")
     #vim.command('term  {} -- {}'.format(target, vim.eval("a:args")))
     vim.command('term  bazel run  {} -- {}'.format(target, vim.eval("a:args")))
 else:
     #vim.command('vert term  {} -- {}'.format(target, vim.eval("a:args")))
     vim.command('vert term  bazel run {} -- {}'.format(target, vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! Convert(args)
python3 << EOF
import vim
try:
 vim.command("call AutoSave()")
 if int(vim.eval("has('nvim')")) == 1:
     vim.command("vsplit")
     vim.command('term  /home/nhendy/bin/freeze_convert.sh  {}'.format( vim.eval("a:args")))
 else:
     vim.command('vert term  /home/nhendy/bin/freeze_convert.sh  {}'.format( vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! RunSafetyNetArgs(args)
python3 << EOF
import vim
try:
 target = "//vehicle/perception/learning/safetynet:run_safetynet"
 vim.command("call AutoSave()")
 if int(vim.eval("has('nvim')")) == 1:
     vim.command("vsplit")
     vim.command('term bazel run {} -- {} --safetynet_mode=kRelease'.format(target, vim.eval("a:args")))
 else:
     vim.command('vert term bazel run {} -- {} --safetynet_mode=kRelease'.format(target, vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction
function! RunSafetyNetCi(args)
python3 << EOF
import vim
try:
 target = "//vehicle/perception/learning/safetynet:ci"
 vim.command("call AutoSave()")
 vim.command("vsplit")
 vim.command('term bazel run {} -- --metrichub_dataset_size {} --no_prediction_metrichub --candidate_only --retention monthly --metrichub_only'.format(target, vim.eval("a:args") or "slac"))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction
function! RunCasCi(args)
python3 << EOF
import vim
try:
 target = "//cas/ci:cas_ci"
 vim.command("vsplit")
 vim.command('term bazel run {} -- --save_chum daily  {}'.format(target, vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

" function! RunD3Validations(args)
" python3 << EOF
" import vim
" try:
"  target = "//cas/ci:cas_ci"
"  vim.command("vsplit")
"  vim.command('term bazel run //hubble/cli:launch -- --merge-base=${branch_name} --d3_latency{,_uap} --d3_sim_sanity{,_uap} --d3_sim{,_uap} --spc{,_uap} --tag "base `git merge-base origin/${branch_name} HEAD`" "${@:1}"'.format(target, vim.eval("a:args")))
" except Exception as e:
"   print("Something went wrong: " + str(e))
" EOF
" endfunction

function! RunD3Uap()
python3 << EOF
import vim
try:
 vim.command("call AutoSave()")
 vim.command("vsplit")
 vim.command('term bazel --bazelrc=$HOME/.all_cuda.bazelrc run --config=cuda //mined_metric/builder:run_metric_builder_prediction_trajectory_metrics -- --metric_id d3_uap --logtostderr --pipedream')
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! RunD3UapRemote(args)
python3 << EOF
import vim
try:
 vim.command("call AutoSave()")
 vim.command("vsplit")
 vim.command("term bazel --bazelrc=~/.all_cuda.bazelrc run --config=cuda //mined_metric/builder/metrics_impl/prediction_trajectory_metrics:run_on_pipedream -- {}".format(vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! RunSafetyNetArgs(args)
python3 << EOF
import vim
try:
 target = "//vehicle/perception/learning/safetynet:run_safetynet"
 vim.command("call AutoSave()")
 vim.command("vsplit")
 vim.command('term')
 vim.command('term bazel run {} -- {} --safetynet_mode=kRelease'.format(target, vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! Precommit()
python3 << EOF
import vim
try:
 vim.command("vsplit")
 vim.command('term pre-commit run -a')
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

function! RunTests(args)
python3 << EOF
import vim
try:
 vim.command("vsplit")
 vim.command('term ~/bin/rt.py {}'.format(vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

" Use K to show documentation in preview window.
nnoremap <leader>K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunctio

nnoremap <leader>u :call UpdateDb()<cr>
nnoremap <leader>z :call Zfix()<cr>

if stridx(getcwd(), 'driving') != -1
    nnoremap <leader>r :call ExecuteBazel()<cr>
    nnoremap <leader>R :call ExecuteBazelArgs("", "")
else
    nnoremap <leader>r :call RunPredResearch("")<cr>
    nnoremap <leader>R :call RunPredResearch("")
endif

if stridx(getcwd(), 'driving') != -1
    nnoremap <leader>T :call Train("--experiment_config prediction/learning/topdown/agent_hero_interactions/uap_models/target_conditioned_uap_v0/experiment_configs/default.pbtxt --debug") <cr>
    nnoremap <leader>Tp :call TrainPip("--experiment_config prediction/learning/topdown/agent_hero_interactions/uap_models/target_conditioned_uap_v0/experiment_configs/default.pbtxt --dm --time_limit_days 7 --partition main_ampere_clustered --auto_retry 2") 
else
    nnoremap <leader>T :call TrainPredResearch("--config projects/scene_diffusion/trafficgen/placement/configs/cluster.hjson") 
    nnoremap <leader>Tp :call TrainPredResearchPd("--config projects/scene_diffusion/trafficgen/placement/configs/cluster.hjson  --pipeline_name testing --timeout_days 5 --n_retries 3") 
endif

if stridx(getcwd(), 'driving') != -1
    nnoremap <leader>Pr :call RunTests("--n_commits 1 --cquery_flags='--config=mlinfra_v3' --bazel_cmd='--config=mlinfra_v3'") 
    nnoremap <leader>B :call BuildBazel() <cr>
else
    nnoremap <leader>B :call RunStreamlit("") <cr>
    nnoremap <leader>Pr :call Precommit() <cr>
endif
" " nnoremap <leader>. :call RunSafetyNet() <cr>
" nnoremap <leader>, :call RunSafetyNetArgs("") 
nnoremap <leader>. :call RunSim2d("--params-kv sim/enable_cas=false --params-kv sim/enable_monitors=false --params-kv scenario_override/options/monitors/validate_dispatch_waypoints=false", "chum://20191007T155916-kitt_18@1570464140.00-1570464150.00") <cr>
" nnoremap <leader>, :call RunSim2dPlayback("--params-kv sim/enable_cas=false --params-kv sim/enable_monitors=false --params-kv scenario_override/options/monitors/validate_dispatch_waypoints=false", "chum://20230418T054322-kitt_49@1681799023+22s") 
nnoremap <leader>, :call RunSim2dPlayback("--params-kv sim/enable_cas=false --params-kv sim/enable_monitors=false --params-kv scenario_override/options/monitors/validate_dispatch_waypoints=false", "chum://20221111T182507-kitt_18@1668193243.43-1668193263.43") 
nnoremap <leader>sp :call RunDecisionPlayer("--chum_uri chum://20221028T235629-kitt_68@1667006903.20+15s --output_dir /mnt/sun-tcs01/pred/users/nhendy/tmp/ --vnc --vnc_password '' --gui") 

nnoremap <leader>D :call RunD3Tick("", "--chum_uri 'chum://20230418T054322-kitt_49@1681799023+22s'  --ztrace --no_checks --tick_count=99999 --num_iterations=5 --ztrace_csv='/tmp/candid.csv' --disable_reproducing_coordinator") 

nnoremap <leader>A :call RunApGenerator("--chum_uri  chum://20220504T051743-kitt_03@1651642223.75-1651642268.75 --metric_id d3_uap") 
" nnoremap <leader>A :call RunTrtExec("--onnx='/mnt/sun-tcs01/pred/users/bmattinson/uap/hero_reactivity/hcg_v14_tln12s3_fix/converted_rm_squeeze/rollout_step/49.onnx' --minShapes=entity_coord_feature:1x1x1x64,entity_state:1x1x1x3,most_likely_target_pose:1x1x1x3,relative_poses:1x1x1x54,node_component_input_hidden_state:1x1x1x96  --optShapes=entity_coord_feature:1x1x16x64,entity_state:1x1x16x3,most_likely_target_pose:1x1x1x3,relative_poses:1x1x16x54,node_component_input_hidden_state:1x1x16x96 --maxShapes=entity_coord_feature:1x1x128x64,entity_state:1x1x128x3,most_likely_target_pose:1x1x128x3,relative_poses:1x1x128x54,node_component_input_hidden_state:1x1x128x96 --fp16 --exportTimes=/tmp/trtexec_times.json --profilingVerbosity=detailed --noTF32 --timingCacheFile=/tmp/timing_cache.txt --verbose --dumpProfile --dumpLayerInfo --exportLayerInfo='/tmp/layer_info.json' --exportProfile='/tmp/trtexec_profile.json' --saveEngine='/tmp/trtexec_engine.trt8p4p3T'") 

nnoremap <leader>; :call RunSuppGenerator("--model_dir <model_dir> --epoch 99 --chum_uri  chum://20220504T051743-kitt_03@1651642223.75-1651642268.75") 
" nnoremap <leader>C :call RunCasCi("--pipedream --metrics_filter timing --mode_filter online") 
nnoremap <leader>M :call RunD3UapRemote("--name d3_uap --ignore_local_changes") 
" nnoremap <leader>C :call Convert("--model_dir /mnt/sun-tcs01/pcp/cas/safetynet/users/nhendy/uap/2022_q3_experiments/bigger_range/v4_rebased_225x225_75vzrn_75target_b36/ --onnx --epoch 99 --suffix_output_dir target_compressed") 
" nnoremap <leader>C :call  ExecuteBazelArgs("--config=mlinfra_v3", "post_process --data_dir /mnt/sun-tcs01/pred/users/nhendy/scene_diffusion/model_outputs/ --output_dir /tmp/scenario_diff")
nnoremap <leader>C :call  ScenarioEditorConvert("post_process --data_dir /mnt/sun-tcs01/pred/users/nhendy/scene_diffusion/model_outputs/ --output_dir /tmp/scenario_diff")


" nnoremap <leader>Tp :call Train("--experiment_config prediction/learning/topdown/agent_hero_interactions/uap_models/target_conditioned_uap_v0/experiment_configs/default.pbtxt") 
" nnoremap <leader>Tp :call TrainPip("--experiment_config prediction/learning/topdown/agent_hero_interactions/uap_models/target_conditioned_uap_v0/experiment_configs/default.pbtxt --dm --time_limit_days 7 --partition main_ampere_clustered --auto_retry 2") 
" nnoremap <leader>Tp :call TrainPredResearchPd("--config projects/scene_diffusion/diffusion/training_configs/default.hjson  --pipeline_name testing --timeout_days 5 --n_retries 3") 

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    au TermOpen  * setlocal nonumber | stopinsert
    au TermClose * setlocal   number | call feedkeys("\<C-\>\<C-n>")
endif

nmap <leader>gh :call SwitchSourceHeader()<CR>
function! Syn()
  for id in synstack(line("."), col("."))
    echo synIDattr(id, "name")
  endfor
endfunction
command! -nargs=0 Syn call Syn()

let s:format_script = expand('<sfile>:p:h:h') . '/scripts/format_file.py'

function! ZFormatFile()
  if empty(&filetype)
    return
  endif
  mkview
  call system([s:format_script, expand("%")]) | edit
  silent! loadview
endfunction

if has("autocmd")
  augroup templates
    autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
    autocmd BufNewFile *.cpp 0r ~/.vim/templates/skeleton.cpp
  augroup END
endif
" autocmd BufWritePost *.pbtxt edit <===== evil
au CursorHold * checktime
" nmap <leader><tab> <plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-p> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" lua << EOF
" local function setup_servers()
"   require'lspinstall'.setup()
"   local servers = require'lspinstall'.installed_servers()
"   for _, server in pairs(servers) do
"     require'lspconfig'[server].setup{}
"   end
" end

" setup_servers()

" -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
" require'lspinstall'.post_install_hook = function ()
"   setup_servers() -- reload installed servers
"   vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
" end
" EOF

" lua << EOF
" local nvim_lsp = require('lspconfig')

" -- Use an on_attach function to only map the following keys 
" -- after the language server attaches to the current buffer
" local on_attach = function(client, bufnr)
"   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
"   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

"   --Enable completion triggered by <c-x><c-o>
"   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

"   -- Mappings.
"   local opts = { noremap=true, silent=true }

"   -- See `:help vim.lsp.*` for documentation on any of the below functions
"   buf_set_keymap('n', 'yl', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
"   buf_set_keymap('n', 'yf', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
"   buf_set_keymap('n', 'yh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
"   buf_set_keymap('n', 'yg', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
"   buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
"   buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
"   buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
"   buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
"   buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
"   buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
"   buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
"   buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
"   buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
"   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
"   buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
"   buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
"   buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
"   buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
"   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

" end

" -- Use a loop to conveniently call 'setup' on multiple servers and
" -- map buffer local keybindings when the language server attaches
" -- local servers = { "pyright" }
" local servers = require'lspinstall'.installed_servers()
" for _, lsp in ipairs(servers) do
"   nvim_lsp[lsp].setup { on_attach = on_attach }
" end
" EOF
