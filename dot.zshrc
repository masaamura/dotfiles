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

if [[ -n ${TERMINAL_NAME} ]]; then
    function terminal_title_precmd() {
        print -Pn "\e]0;${TERMINAL_NAME} %m: ${ZSH_NAME} ${COLUMNS}×${LINES}\a"
    }
    function terminal_title_preexec() {
        print -Pn "\e]0;${TERMINAL_NAME} %m: $history[$HISTCMD] ${COLUMNS}×${LINES}\a"
    }
    add-zsh-hook -Uz precmd terminal_title_precmd
    add-zsh-hook -Uz preexec terminal_title_preexec
fi

### mise
if [[ -x ~/.local/bin/mise ]]; then
    eval "$(~/.local/bin/mise activate zsh)"
    #eval "$(~/.local/bin/mise activate --shims)"
fi

### cd by history
function powered_cd_add_log() {
    [ -e ~/.powered_cd.log ] || touch ~/.powered_cd.log
    local i=0
    cat ~/.powered_cd.log | while read line; do
        (( i++ ))
        if [ i = 30 ]; then
            sed -i -e "30,30d" ~/.powered_cd.log
        elif [ "$line" = "$PWD" ]; then
            sed -i -e "${i},${i}d" ~/.powered_cd.log
        fi
    done
    echo "$PWD" >> ~/.powered_cd.log
}

function powered_cd() {
    [ -e ~/.powered_cd.log ] || touch ~/.powered_cd.log
    if [ $# = 0 ]; then
        cd $(tac ~/.powered_cd.log | fzf)
    elif [ $# = 1 ]; then
        cd $1
    else
        echo "powered_cd: too many arguments"
    fi
}

_powered_cd() {
    _files -/
}

compdef _powered_cd powered_cd

add-zsh-hook -Uz chpwd powered_cd_add_log

alias c='powered_cd'

## emacs
if type emacs > /dev/null 2>&1; then
    server_running_p() {
       emacsclient --eval '(server-running-p)' >/dev/null 2>&1
    }

    if server_running_p
    then
        echo "emacs daemon already running."
    else
        if [[ ! -n "${MSYSTEM}" || "${MSYSTEM}" = "MINGW64" ]]; then
            #emacs --daemon &
            echo "you can start emacs daemon."
        else
            echo "cannot execute emacs daemon."
        fi
    fi

    alias E='emacsclient'
    alias killemacs="emacsclient -e '(kill-emacs)'"
fi

### starship
if type starship > /dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

#show_path "end of zshrc"

echo "\"${TERM_PROGRAM}\""
echo "\"${TERMINAL_NAME}\""
env | grep MSYS
