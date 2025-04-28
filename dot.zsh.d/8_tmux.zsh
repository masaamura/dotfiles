### tmux
TMUXCMD=""
if type tmux > /dev/null 2>&1; then
    TMUXCMD="tmux"
else
    # echo "tmux not found."
fi
FZFCMD=""
if type fzf > /dev/null 2>&1; then
    FZFCMD="fzf"
else
    # echo "fzf not found."
fi

if [[ -n $TMUXCMD && -n $FZFCMD ]]; then
    #echo $-
    #echo $TMUX
    if [[ ! -n $TMUX && $- == *l* ]]; then
        # outside of tmux session
        # get sessions list
        ID="`tmux list-sessions`"
        if [[ -z "$ID" ]]; then
            # has no sessions, create new one
            tmux new-session
        else
            # sellect session or new
            NEW="Create new session"
            ID="$ID\n${NEW}"
            ID="`echo $ID | fzf | cut -d: -f1`"
            if [[ "$ID" = $NEW ]]; then
                # new
                tmux new-session
            elif [[ -n "$ID" ]]; then
                # attach selected session
                tmux attach-session -t "$ID"
            else
                :
            fi
        fi
    fi
fi
