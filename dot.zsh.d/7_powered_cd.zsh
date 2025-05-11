### cd by history

function powered_cd_add_log() {
    # ログが無い時は作成する
    [ -e ~/.powered_cd.log ] || touch ~/.powered_cd.log

    local tmp_file=$(mktemp)

    # 直近の30項目だけ残し、現在のディレクトリを最後に追加する
    # 途中に現在のディレクトリがあったら削除する
    awk -v "cwd=$PWD" '
        { lines[NR] = $0 }
    END { start = length(lines) + 1 - 30
          if (start < 1) start = 1
          for (i = start; i < length(lines) + 1; ++i) {
              if (lines[i] != "" && lines[i] != cwd) {
                  print(lines[i])
              }
          }
          print(cwd)
    }
        ' ~/.powered_cd.log >! "$tmp_file"

    # ログを書き換える
    /bin/cp "$tmp_file" ~/.powered_cd.log
    /bin/rm "$tmp_file"
}

function powered_cd() {
    # ログが無い時は作成する
    [ -e ~/.powered_cd.log ] || touch ~/.powered_cd.log

    local tmp_file=$(mktemp)

    # 存在しないディレクトリは削除する
    awk '
        { if (system("[ -d \"" $0 "\" ]") == 0) {
              print($0)
        }
    }
        ' ~/.powered_cd.log >! "$tmp_file"

    # ログを書き換える
    /bin/cp "$tmp_file" ~/.powered_cd.log
    /bin/rm "$tmp_file"

    if [ $# = 0 ]; then
        # fzf で選択
        cd $(tac ~/.powered_cd.log | fzf)
    elif [ $# = 1 ]; then
        # オプションがあれば、そこへ移動
        cd $1
    else
        echo "powered_cd: too many arguments"
    fi
}

_powered_cd() {
    _files -/
}

#compdef _powered_cd powered_cd
#add-zsh-hook -Uz chpwd powered_cd_add_log
#alias C='powered_cd'


### fasd
if type fasd > /dev/null 2>&1; then
    eval "$(fasd --init zsh-hook)"
fi

### fxf-extras
[[ -e "$HOME/.fzf-extras/fzf-extras.sh" ]] \
  && source "$HOME/.fzf-extras/fzf-extras.sh"
#[[ -e "$HOME/.fzf-extras/fzf-extras.zsh" ]] \
#  && source "$HOME/.fzf-extras/fzf-extras.zsh"
