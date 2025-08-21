### aliases

# vim is neovim
if type nvim > /dev/null 2>&1; then
    alias vim=nvim
    alias vi=nvim
    alias V=nvim
else
    alias vi=vim
    alias V=vim
fi

# ls is eza
if type eza > /dev/null 2>&1; then
    alias ls='eza --classify --group-directories-first --color=auto'
else
    # eza はパッケージマネージャで導入
    echo "eza is not installed."
    alias ls='ls --classify --group-directories-first --color=auto'
fi
alias la='ls -A'
alias ll='ls -l'

alias cp='nocorrect cp -aiv'
alias mv='nocorrect mv -iv'
alias rm='nocorrect rm -iv'

# git
alias gits='git status'

# bat
if type batcat > /dev/null 2>&1; then
    alias cat="batcat --paging=never"
    alias less='batcat --paging=always'
    alias more='batcat --paging=always'
else
    if type bat > /dev/null 2>&1; then
        alias cat="bat --paging=never"
        alias less='bat --paging=always'
        alias more='bat --paging=always'
    else
        echo "bat is not installed."
    fi
fi
