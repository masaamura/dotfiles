### mise
if [ "$(uname -s)" = "Linux" ]; then
    if type mise > /dev/null; then
        eval "$(mise activate zsh)"
        #eval "$(mise activate --shims)"
    else
        echo "mise is not installed"
    fi
fi
