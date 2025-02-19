### mise
if [[ -x ~/.local/bin/mise ]]; then
    eval "$(~/.local/bin/mise activate zsh)"
    #eval "$(~/.local/bin/mise activate --shims)"
else
    echo "mise is not installed"
fi
