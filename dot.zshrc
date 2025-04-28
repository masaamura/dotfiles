# .zshrc
#
autoload -Uz compinit && compinit

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

### starship
if type starship > /dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

#show_path "end of zshrc"

echo "TERM_PROGRAM=\"${TERM_PROGRAM}\""
echo "TERMINAL_NAME=\"${TERMINAL_NAME}\""
env | grep MSYS
