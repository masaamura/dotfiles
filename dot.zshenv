# Created by newuser for 5.9

if type nvim > /dev/null 2>&1; then
    export EDITOR=nvim
    export PAGER=nvim
else
    export EDITOR=vim
    export PAGER=vim
fi

export PAGER=lv
export LV="-c"

function show_path() {
   echo $1
   echo $PATH | /usr/bin/sed 's/:/\n/g'
   echo
}

#show_path "end .zshenv"
