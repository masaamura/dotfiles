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
        ID="`tmux list-sessions 2> /dev/null`"
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
elif [[ -n $TMUXCMD ]]; then
    if [[ ! -n $TMUX && $- == *l* ]]; then
        ID="`tmux list-sessions 2> /dev/null`"
        if [[ -n "$ID" ]]; then
            echo $ID
        fi
    fi
fi

# unameコマンドでOSを判定
if [ "$(uname -s)" = "Linux" ]; then
    echo "Linux環境です。"
elif [ "$(uname -s)" = "Darwin" ]; then
    echo "macOS環境です。"
# Windows Subsystem for Linuxなどの環境に対応
elif [[ "$(uname -s)" == CYGWIN_NT* ]] || [[ "$(uname -s)" == MINGW* ]] || [[ "$(uname -s)" == MSYS_NT* ]]; then
    echo "Windows環境 (WSLなど) です。"
else
    echo "その他OSです。"
fi

# check first of the day
FIRST_FILE="$HOME/.first_of_the_day"
FIRST_EXEC=0
FIRST_NOW=$(date +%D)
# echo $FETCH_NOW
if [[ -e $FIRST_FILE ]]; then
    cat $FIRST_FILE | read FIRST_HISTORY
    # echo $FETCH_HISTORY
    if [[ $FIRST_NOW != $FIRST_HISTORY ]]; then
        FIRST_EXEC=1
    fi
else
    FIRST_EXEC=1
fi
if [[ $FIRST_EXEC == "1" ]]; then
    echo $FIRST_NOW >! $FIRST_FILE
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

### history
# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history
# メモリに保存される履歴の件数
export HISTSIZE=100000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000
# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt EXTENDED_HISTORY
# historyの共有
setopt share_history
# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
# 余分な空白は詰めて記録
setopt hist_reduce_blanks  
# 古いコマンドと同じものは無視 
setopt hist_save_no_dups
# historyコマンドは履歴に登録しない
setopt hist_no_store
# 補完時にヒストリを自動的に展開         
setopt hist_expand
# 履歴をインクリメンタルに追加
setopt inc_append_history
# インクリメンタルからの検索
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

### bat
if type bat > /dev/null 2>&1; then
    NULLCMD="bat"
    READNULLCMD="bat"
elif type batcat > /dev/null 2>&1; then
    NULLCMD="batcat"
    READNULLCMD="batcat"
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

### emacs
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
    kill-emacs-server() {
        if server-running-p; then
            echo "stop emacs daemon"
            emacsclient -e '(kill-emacs)'
        else
            echo "emacs daemon is NOT running"
        fi
    }
    is-emacs-server-running() {
        if server-running-p; then
            echo "emacs daemon is running"
        else
            echo "emacs daemon is NOT running"
        fi
    }
fi

### rustup
if [[ -e "$HOME/.cargo/env" ]]; then
    . $HOME/.cargo/env
fi

### starship
if type starship > /dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

echo "TERM_PROGRAM=\"${TERM_PROGRAM}\""
echo "TERMINAL_NAME=\"${TERMINAL_NAME}\""
env | grep MSYS

# check backup media
check_backup_dir() {
    if [[ ! -d /media/Marshal/backups ]]; then
        echo
        echo "Please mount USB drive Marshal for backup your life."
    fi
}
add-zsh-hook -Uz chpwd check_backup_dir

if [[ $FIRST_EXEC == "1" && $- == *l* ]]; then
    if type hyfetch > /dev/null 2>&1 ; then
        hyfetch
    elif type neowofetch > /dev/null 2>&1 ; then
        neowofetch
    elif type neofetch > /dev/null 2>&1 ; then
        neofetch
    fi
fi

echo
ls_abbrev

if [[ $- == *l* ]]; then
    if [[ ! -d /media/Marshal/backups ]]; then
        echo
        echo "Please mount USB drive Marshal for backup your life."
    fi
fi
