### show file list when change directory
ls_abbrev() {
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='/bin/ls'
    local -a opt_ls
    opt_ls=('-CF' '--color=always' '--group-directories-first' )
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type /usr/local/bin/gls > /dev/null 2>&1; then
                cmd_ls='/usr/local/bin/gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-CFG')
            fi
            ;;
    esac
    if type eza > /dev/null 2>&1; then
        cmd_ls='eza'
        opt_ls=('-F' '--color=always' '--group-directories-first' )
    fi

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}

add-zsh-hook -Uz chpwd ls_abbrev
