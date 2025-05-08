### aliases

# vim is neovim
if type nvim > /dev/null 2>&1; then
    alias vim=nvim
    alias vi=nvim
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
