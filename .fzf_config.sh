# fd() {
#   local dir
#   dir=$(find ${1:-.} -path '*/\.*' -prune \
#                   -o -type d -print 2> /dev/null | fzf +m) &&
#   cd "$dir"
# }


# Options to fzf command
# export FZF_BASE=/Users/noureldinhendy/.fzf/bin/fzf
# export DISABLE_FZF_KEY_BINDINGS="false"
# export DISABLE_FZF_AUTO_COMPLETION="false"
export FZF_COMPLETION_OPTS='--border --info=inline'
export FZF_DEFAULT_COMMAND="fd --type file --color=always"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
# _fzf_compgen_path() {
#   fd --hidden --follow --exclude ".git" . "$1"
# }

# # Use fd to generate the list for directory completion
# _fzf_compgen_dir() {
#   fd --type d --hidden --follow --exclude ".git" . "$1"
# }

# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
# _fzf_comprun() {
#   local command=$1
#   shift

#   case "$command" in
#     cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
#     export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
#     ssh)          fzf "$@" --preview 'dig {}' ;;
#     *)            fzf "$@" ;;
#   esac
# }

if [ -n "$ZSH_VERSION" ]; then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    [ -d ~/.forgit.git/ ] && source ~/.forgit.git/forgit.plugin.zsh
elif [ -n "$BASH_VERSION" ]; then
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
    [ -d ~/.forgit.git/ ] && source ~/.forgit.git/forgit.plugin.sh
fi

# vf - fuzzy open with vim from anywhere
# ex: vf word1 word2 ... (even part of a file name)
# zsh autoload function
# vf() {
#   local files

#   files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})

#   if [[ -n $files ]]
#   then
#      vim -- $files
#      print -l $files[1]
#   fi
# }

# fuzzy grep open via ag
vg() {
  local file

  file="$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1}')"

  if [[ -n $file ]]
  then
     vim $file
  fi
}
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
# f() {
#     # Store the program
#     program="$1"

#     # Remove first argument off the list
#     shift

#     # Store option flags with separating spaces, or just set as single space
#     options="$@"
#     if [ -z "${options}" ]; then
#         options=" "
#     else
#         options=" $options "
#     fi

#     # Store the arguments from fzf
#     arguments=($(fzf --multi))

#     # If no arguments passed (e.g. if Esc pressed), return to terminal
#     if [ -z "${arguments}" ]; then
#         return 1
#     fi

#     # We want the command to show up in our bash history, so write the shell's
#     # active history to ~/.bash_history. Then we'll also add the command from
#     # fzf, then we'll load it all back into the shell's active history
#     history -w

#     # ADD A REPEATABLE COMMAND TO THE BASH HISTORY ############################
#     # Store the arguments in a temporary file for sanitising before being
#     # entered into bash history
#     : > /tmp/fzf_tmp
#     for file in "${arguments[@]}"; do
#         echo "$file" >> /tmp/fzf_tmp
#     done

#     # Put all input arguments on one line and sanitise the command by putting
#     # single quotes around each argument, also first put an extra single quote
#     # next to any pre-existing single quotes in the raw argument
#     sed -i "s/'/''/g; s/.*/'&'/g; s/\n//g" /tmp/fzf_tmp

#     # If the program is on the GUI list, add a '&' to the command history
#     if [[ "$program" =~ ^(nautilus|zathura|evince|vlc|eog|kolourpaint)$ ]]; then
#         sed -i '${s/$/ \&/}' /tmp/fzf_tmp
#     fi

#     # Grab the sanitised arguments
#     arguments="$(cat /tmp/fzf_tmp)"

#     # Add the command with the sanitised arguments to our .bash_history
#     echo $program$options$arguments >> ~/.bash_history

#     # Reload the ~/.bash_history into the shell's active history
#     history -r

#     # EXECUTE THE LAST COMMAND IN ~/.bash_history #############################
#     fc -s -1

#     # Clean up temporary variables
#     rm /tmp/fzf_tmp
# }
# fhe - repeat history edit
# writecmd (){ perl -e 'ioctl STDOUT, 0x5412, $_ for split //, do{ chomp($_ = <>); $_  }' ;  }

# fhe() {
#       ([ -n "$ZSH_NAME"  ] && fc -l 1 || history) | fzf +s --tac | sed -e 's/^\s*[0-9]+\s*//' | writecmd

# }
# alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
# _gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
# _viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

# # fcoc_preview - checkout git commit with previews
# fcoc_preview() {
#   local commit
#   commit=$( glNoGraph |
#     fzf --no-sort --reverse --tiebreak=index --no-multi \
#         --ansi --preview="$_viewGitLogLine" ) &&
#   git checkout $(echo "$commit" | sed "s/ .*//")
# }

# # fshow_preview - git commit browser with previews
# fshow_preview() {
#     glNoGraph |
#         fzf --no-sort --reverse --tiebreak=index --no-multi \
#             --ansi --preview="$_viewGitLogLine" \
#                 --header "enter to view, alt-y to copy hash" \
#                 --bind "enter:execute:$_viewGitLogLine   | less -R" \
#                 --bind "alt-y:execute:$_gitLogLineToHash | xclip"
# }

if [ -d ~/.bash_completion.d ]; then
  for file in ~/.bash_completion.d/*; do
    . $file
  done
fi
function cd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && ls -p | ag '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p -fg "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}
unalias z
z() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
  else
    _last_z_args="$@"
    _z "$@"
  fi
}

zz() {
  cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")"
}
alias j=z
alias jj=zz
export EDITOR=vim
export FD_OPTIONS="--hidden --follow --ignore-file ~/.ignore"
export FZF_DEFAULT_OPTS="--no-mouse --height 80% --reverse --multi --info=inline --preview='$HOME/.vim/bundle/fzf.vim/bin/preview.sh {}' --preview-window='right:60%:wrap' --bind='f2:toggle-preview,f3:execute(bat --style=numbers {} || less -f {}),alt-o:execute(vim {}),alt-w:toggle-preview-wrap,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-y:execute-silent(echo {+} | pbcopy),ctrl-x:execute(rm -i {+})+abort,ctrl-l:clear-query,alt-k:preview-page-up,alt-j:preview-page-down'"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard 2>/dev/null || fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

