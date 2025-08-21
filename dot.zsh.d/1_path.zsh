### path
# scoop
#path=($HOME/scoop/shims(N-/) $path)

# winget
# link は自分でやること
#path=($HOME/winget/shims(N-/) $path)

path=($HOME/.local/bin(N-/) $path)

# flutter
path=($HOME/development/flutter/bin(N-/) $path)

# Android SDK
path=($HOME/development/android/sdk/platform-tools(N-/) $path)

# Android Studio
path=(/usr/local/android-studio/bin(N-/) $path)

# doom emacs
path=($HOME/.config/emacs.doom/bin(N-/) $path)

# emacs
#path=($HOME/emacs/emacs-29.4/bin(N-/) $path)

# my bin
path=($HOME/bin(N-/) $path)

# sentencepiece, emacs
if [[ ${OSTYPE} == linux* ]]; then
    path=($HOME/bin/sentencepiece/bin(N-/) $path)
    export LD_LIBRARY_PATH=$HOME/bin/sentencepiece/lib${LD_LIBRARY_PATH+:}${LD_LIBRARY_PATH}

    path=($HOME/bin/emacs/bin(N-/) $path)
fi

# isync
path=($HOME/bin/isync/bin(N-/) $path)

# 重複を削除
if [[ ${OSTYPE} == linux* ]]; then
    typeset -TU LD_LIBRARY_PATH ld_library_path
fi
