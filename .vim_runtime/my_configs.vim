set relativenumber 
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set shell=/bin/bash
set mouse=a
set number relativenumber
set nu rnu
set nobackup
set nowritebackup

set cmdheight=2

set updatetime=100

set shortmess+=c
" set signcolumn=yes
set splitbelow
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
let g:github_enterprise_urls = ['https://git.zooxlabs.com']
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
" set path=$PWD/**
" set path+=$PATH
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:vim_markdown_folding_disabled = 1
" let g:loaded_youcompleteme = 1
let g:deoplete#enable_at_startup = 1
let s:molokai_original = 1
let g:rehash256 = 0
" let g:ycm_collect_identifiers_from_tags_files=1
" let g:ycm_enable_diagnostic_signs = 0
" let g:ycm_enable_diagnostic_highlighting = 0
let g:clang_format_executable="clang-format-3.6"
let NERDTreeShowBookmarks = 1
let g:cpp_experimental_simple_template_highlight = 0
let g:go_version_warning = 0
let g:auto_save = 1
let g:move_map_keys =1
let g:move_auto_indent=1
let g:move_key_modifier='S'
let g:python_highlight_all = 1
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
let g:gutentags_ctags_exclude = [
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
      \ ]
" let g:ale_lint_on_enter = 0 
" let g:ale_lint_on_text_changed = 'never' 
" let g:ale_lint_on_save = 0
" let g:ale_set_highlights = 0
nmap <leader>sa :ALEFix<CR>
nmap <leader>ss :ALELint<CR>
" let g:lsp_highlights_enabled = 0
" let g:lsp_textprop_enabled = 0
" let g:lsp_signs_enabled = 0     
" let g:lsp_diagnostics_echo_cursor = 0
set statusline+=%{gutentags#statusline()}
"let g:gutentags_define_advanced_commands = 1
"" enable gtags module
" let g:gutentags_modules = ['ctags']
""
" config project root markers.
" let g:gutentags_project_root = ['.root', '.git']
 " let g:gutentags_generate_on_missing=1
 " let g:gutentags_generate_on_new=1
""
let g:gutentags_generate_on_write = 1
""" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

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
" nnoremap <leader>c :FormatCode<CR> 
nmap <leader>t :TagbarToggle<CR>
nnoremap <leader>gb :<C-u>call gitblame#echo()<CR>
" nmap <silent> gd <Plug>(coc-definition)
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
" Create a function to reload vimrc. Checks if it already exists to avoid
" redefining the function during the function call.
" function! SourceVimrc()
"     so ~/.vim_runtime/my_configs.vim
" endfunction
 command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))

" function ClangFormatFile()
"  let l:lines="all"
"  pyf ~/clang-format.py
" endfunction
 nnoremap <leader>c :FormatCode<cr>
 " nnoremap <leader>c :call ClangFormatFile()<cr>

" nnoremap <leader>. :call SourceVimrc()<cr>

nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" augroup autoformat_settings
"   autocmd FileType bzl AutoFormatBuffer buildifier
"   " autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
"   autocmd FileType dart AutoFormatBuffer dartfmt
"   autocmd FileType go AutoFormatBuffer gofmt
"   autocmd FileType gn AutoFormatBuffer gn
"   autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
"   autocmd FileType java AutoFormatBuffer google-java-format
"   autocmd FileType python AutoFormatBuffer yapf
"   " Alternative: autocmd FileType python AutoFormatBuffer autopep8
"   autocmd FileType rust AutoFormatBuffer rustfmt
"   autocmd FileType vue AutoFormatBuffer prettier
" augroup END
autocmd FileType python let b:codefmt_formatter = 'yapf'

function! GotoProtoDef()
:  let l:fname=expand('<cfile>')
:  let l:fname = substitute(l:fname, ".pb.h", ".proto", "")
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
noremap <Leader>a :Ack <cword>

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
  py3f /home/nhendy/freshen_deps.py
  call input('Press any key to continue')
  redraw!
  execute 'edit' l:fname
endfunction
nnoremap ,u :call UpdateDeps()<cr>


" Type `gd` to go to the BUILD file for this file.
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
 fn = vim.current.buffer.name
 basename = os.path.basename(fn)
 basename, _ = os.path.splitext(basename)
 dirname = os.path.dirname(fn)
 target = "{prefix}:{binary}".format(prefix=re.sub("/home/nhendy/driving[0-9]?", "/", dirname), binary=basename)
 vim.command("vsplit")
 vim.command('terminal bazel run {}'.format(target))
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
 fn = vim.current.buffer.name
 basename = os.path.basename(fn)
 basename, _ = os.path.splitext(basename)
 dirname = os.path.dirname(fn)
 target = "{prefix}:{binary}".format(prefix=re.sub("/home/nhendy/driving[0-9]?", "/", dirname), binary=basename)
 vim.command("split")
 vim.command('terminal bazel build {}'.format(target))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction
function! ExecuteBazelArgs(args)
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
 target = "{prefix}:{binary}".format(prefix=re.sub("/home/nhendy/driving[0-9]?", "/", dirname), binary=basename)
 vim.command("vsplit")
 vim.command('term bazel run {} -- {}'.format(target, vim.eval("a:args")))
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
try:
 fn = vim.current.buffer.name
 basename = os.path.basename(fn)
 basename, _ = os.path.splitext(basename)
 dirname = os.path.dirname(fn)
 target = "{prefix}:{binary}".format(prefix=re.sub("/home/nhendy/driving[0-9]?", "/", dirname), binary=basename)
 vim.command("vsplit")
 vim.command('term source {}/scripts/shell/zooxrc.sh && pipedream/tools/run bazel --gpus=1 --slack_targets @nhendy --docker_args="--runtime=nvidia" --name {} {} {} -- {}'.format(os.getcwd(), basename, vim.eval("a:pipeargs"), target, vim.eval("a:args")))
except Exception as e:
  print("Something went wrong: " + str(e))
EOF
endfunction

nnoremap <leader>r :call ExecuteBazel()<cr>
nnoremap <leader>R :call ExecuteBazelArgs("")
nnoremap <leader>B :call BuildBazel() <cr>

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
    autocmd BufNewFile *_leetcode.cpp 0r ~/.vim/templates/skeleton_leetcode.cpp
  augroup END
endif


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
"   buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
"   buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
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
