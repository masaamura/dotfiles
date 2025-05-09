#!/bin/zsh

# .zshrc
#
autoload -Uz compinit && compinit

### tmux
TMUXCMD=""
if type tmux > /dev/null 2>&1; then
    TMUXCMD="tmux"
else
    echo "tmux not found."
fi
FZFCMD=""
if type fzf > /dev/null 2>&1; then
    FZFCMD="fzf"
else
    echo "fzf not found."
fi

if [[ -n $TMUXCMD && -n $FZFCMD ]]; then
    # echo $-
    # echo $TMUX
    if [[ ! -n $TMUX && $- == *l* ]]; then
        # outside of tmux session
        # get sessions list
        NEW="Create new session"
        ID="`tmux list-sessions`"
        if [[ -n "$ID" ]]; then
            ID="$ID\n${NEW}"
        else
            ID="${NEW}"
        fi
        ID="`echo $ID | fzf | cut -d: -f1`"
        if [[ "$ID" = $NEW ]]; then
            # new
            tmux new-session
            exit
        elif [[ -n "$ID" ]]; then
            # attach selected session
            tmux attach-session -t "$ID"
            exit
        else
            :
        fi
    fi
fi

### execute scripts in ~/.zsh.d
ZSHDIR=${HOME}/.zsh.d

OLDIFS=$IFS
IFS=$'\n'
ZSHFILES=($(find -H $ZSHDIR -maxdepth 1 -type f -name "*.zsh" | sort -n))
IFS=$OLDIFS

for z in ${ZSHFILES[@]}; do
    echo "execute" $z
    . $z
done

if type bat > /dev/null 2>&1; then
    NULLCMD="bat --paging=never"
    READNULLCMD="bat --paging=always"
elif type batcat > /dev/null 2>&1; then
    NULLCMD="batcat --paging=never"
    READNULLCMD="batcat --paging=always"
fi

### Window titl
# set terminal name
TERMINAL_NAME=""
if [[ -n $ALACRITTY_LOG ]]; then
    TERMINAL_NAME="Alacritty"
elif [[ "${TERM_PROGRAM}" = "mintty" ]]; then
    TERMINAL_NAME="Mintty"
elif [[ "${TERM_PROGRAM}" = "tmux" ]]; then
    TERMINAL_NAME="Tmux"
fi
if [[ -n ${TERMINAL_NAME} && -n ${MSYSTEM} ]]; then
    TERMINAL_NAME="${TERMINAL_NAME} ${MSYSTEM}"
fi

# set hook functions
#if [[ -n ${TERMINAL_NAME} ]]; then
#    function terminal_title_precmd() {
#        print -Pn "\e]0;${TERMINAL_NAME} %m: ${ZSH_NAME} ${COLUMNS}×${LINES}\a"
#    }
#    function terminal_title_preexec() {
#        print -Pn "\e]0;${TERMINAL_NAME} %m: $history[$HISTCMD] ${COLUMNS}×${LINES}\a"
# }
#    add-zsh-hook -Uz precmd terminal_title_precmd
#    add-zsh-hook -Uz preexec terminal_title_preexec
#fi

## emacs
if type emacs > /dev/null 2>&1; then
    server-running-p() {
       emacsclient --eval '(server-running-p)' >/dev/null 2>&1
    }

    if server-running-p; then
        echo "emacs daemon already running."
    else
        if [[ -z "${MSYSTEM}" ]]; then
            #echo "Not MSYS2"
            #echo "start emacs daemon"
            #emacs --daemon
        else
            #echo "MSYS2"
            if [[! "${MSYSTEM}" = "MINGW64" ]]; then
                echo "you can start emacs daemon."
                #echo "start emacs daemon"
                #emacs --daemon &
            else
                echo "cannot execute emacs daemon."
            fi
        fi
    fi

    alias E='emacsclient'
    kill-emacs() {
        if server-running-p; then
            echo "stop emacs daemon"
            emacsclient -e '(kill-emacs)'
        else
            echo "emacs daemon is NOT running"
        fi
    }
fi

### fasd
eval "$(fasd --init auto)"

### fxf-extras
unalias zz
[[ -e "$HOME/.fzf-extras/fzf-extras.sh" ]] \
  && source "$HOME/.fzf-extras/fzf-extras.sh"
[[ -e "$HOME/.fzf-extras/fzf-extras.zsh" ]] \
  && source "$HOME/.fzf-extras/fzf-extras.zsh"

### rustup
. $HOME/.cargo/env

### starship
if type starship > /dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

#show_path "end of zshrc"

echo "TERM_PROGRAM=\"${TERM_PROGRAM}\""
echo "TERMINAL_NAME=\"${TERMINAL_NAME}\""
env | grep MSYS
