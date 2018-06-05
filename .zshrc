# -------------------------------------
# 環境変数
# -------------------------------------

# SSHで接続した先で日本語が使えるようにする
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# エディタ
export EDITOR=/usr/bin/vim

# ページャ
export PAGER=/usr/local/bin/vimpager
export MANPAGER=/usr/local/bin/vimpager

# python
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

# ant
export ANT_HOME=/usr/bin/apache-ant-1.9.4

# -------------------------------------
# zshのオプション
# -------------------------------------

## 補完機能の強化
autoload -U compinit
compinit

## 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct

# ビープを鳴らさない
setopt nobeep

## 色を使う
setopt prompt_subst

## ^Dでログアウトしない。
setopt ignoreeof

## バックグラウンドジョブが終了したらすぐに知らせる。
setopt no_tify

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

# 補完
## タブによるファイルの順番切り替えをしない
unsetopt auto_menu

# cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
setopt auto_pushd

# ディレクトリ名を入力するだけでcdできるようにする
setopt auto_cd

# -------------------------------------
# パス
# -------------------------------------

# 重複する要素を自動的に削除
typeset -U path cdpath fpath manpath

path=(
    $HOME/bin(N-/)
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    /usr/local/sbin(N-/)
    /Applications/android-sdk-macosx/tools(N-/)
    $ANT_HOME/bin(N-/)
    $path
)

# -------------------------------------
# プロンプト
# -------------------------------------

autoload -U promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least

# begin VCS
zstyle ":vcs_info:*" enable git svn hg bzr
zstyle ":vcs_info:*" formats "(%s)-[%b]"
zstyle ":vcs_info:*" actionformats "(%s)-[%b|%a]"
zstyle ":vcs_info:(svn|bzr):*" branchformat "%b:r%r"
zstyle ":vcs_info:bzr:*" use-simple true

zstyle ":vcs_info:*" max-exports 6

if is-at-least 4.3.10; then
    zstyle ":vcs_info:git:*" check-for-changes true # commitしていないのをチェック
    zstyle ":vcs_info:git:*" stagedstr "<S>"
    zstyle ":vcs_info:git:*" unstagedstr "<U>"
    zstyle ":vcs_info:git:*" formats "(%b) %c%u"
    zstyle ":vcs_info:git:*" actionformats "(%s)-[%b|%a] %c%u"
fi

function vcs_prompt_info() {
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && echo -n " %{$fg[yellow]%}$vcs_info_msg_0_%f"
}
# end VCS

OK="^_^ "
NG="X_X "

PROMPT=""
PROMPT+="%(?.%F{green}$OK%f.%F{red}$NG%f) "
PROMPT+="%F{blue}%~%f"
PROMPT+="\$(vcs_prompt_info)"
PROMPT+="
"
PROMPT+="%% "

RPROMPT="[%*]"

# -------------------------------------
# エイリアス
# -------------------------------------

# -n 行数表示, -I バイナリファイル無視, svn関係のファイルを無視
alias grep="grep --color -n -I --exclude='*.svn-*' --exclude='entries' --exclude='*/cache/*'"

# ls
alias ls="ls -G" # color for darwin
alias l="ls -la"
alias la="ls -la"
alias l1="ls -1"
alias ll="ls -l"

# tree
alias tree="tree -NC" # N: 文字化け対策, C:色をつける

# clear
alias c="clear"
alias cl="clear; ls -l"

alias cdgo="cd ~/go/src/github.com/andfactory/$(basename $(pwd))"

# ssh拡張
function ssh {
  # iTermのタブタイトルを変更
  tab-title $1

  # iTermのプロファイルを変更
  if [ `echo "$1" | grep "Dev"` ]; then
    change-profile dev
  else
    change-profile prod
  fi

  /usr/bin/ssh $@

  # iTermのタブタイトルとプロファイルをリセット
  tab-title localhost
  change-profile normal
}

# vagrant拡張
function vagrant {

  # iTerm色を変更
  if [ "$1" = "ssh" ]; then
    tab-color 128 128 255
  fi

  /usr/local/bin/vagrant $@

  # iTermの色をリセット
  if [ "$1" = "ssh" ]; then
    tab-reset
  fi
}

# -------------------------------------
# キーバインド
# -------------------------------------

bindkey -e

function cdup() {
   echo
   cd ..
   zle reset-prompt
}
zle -N cdup
bindkey '^K' cdup

bindkey "^R" history-incremental-search-backward

# -------------------------------------
# その他
# -------------------------------------

# cdしたあとで、自動的に ls する
function chpwd() { ls -l }

# iTerm2のタブ名を変更する
function tab-title {
  echo -ne "\033]0;"$*"\007"
}

# iTermのタブ色を設定する
tab-color() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}

# iTermのタブ色をリセットする
tab-reset() {
    echo -ne "\033]6;1;bg;*;default\a"
}

# iTermのプロファイルを変更する
change-profile() {
    echo -ne "\033]1337;SetProfile=$1\a"
}

# -------------------------------------
# Ruby
# -------------------------------------
eval "$(rbenv init - zsh)"

# -------------------------------------
# Go
# -------------------------------------
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

NODEBREW_HOME=/usr/local/var/nodebrew/current
export NODEBREW_HOME
export NODEBREW_ROOT=/usr/local/var/nodebrew

export PATH=$PATH:$NODEBREW_HOME/bin

