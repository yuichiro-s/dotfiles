source ~/.zplug/init.zsh

# auto completion
fpath=($HOME/dotfiles/zsh-completions/src(N-/) $fpath)
autoload -U compinit
compinit -u

# history search
function fzf-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(\history -n 1 | eval $tac | fzf --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}

function search-history() {
  if type fzf > /dev/null 2>&1; then
    fzf-select-history
  else
    # fzf not found
    zle history-incremental-search-backward
  fi
}
zle -N search-history
bindkey "^r" search-history
bindkey "^s" history-incremental-search-forward

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# directory
setopt auto_cd

setopt auto_pushd
setopt pushd_ignore_dups

setopt extended_glob

# magic abbrev expand
typeset -A abbreviations
abbreviations=(
"L"    "| less"
"F"    "| fzf"
)

magic-abbrev-expand() {
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9]#}
  LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
  zle self-insert
}

no-magic-abbrev-expand() {
  LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand

# buffer stack
show_buffer_stack() {
  POSTDISPLAY="
  stack: $LBUFFER"
  zle push-line
}
zle -N show_buffer_stack
bindkey "^q" show_buffer_stack

# history
export HISTFILE=~/.zsh_history
export HISTSIZE=100000000
export SAVEHIST=100000000
setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space
setopt extended_history
setopt hist_verify

zstyle ':completion:*:default' menu select=2
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# ls
alias ll='ls -l'
alias la='ll -a'
cl()
{
  # sort by access time
  if [[ "$OSTYPE" == darwin* ]]; then
    tm='-u'
  elif [[ "$OSTYPE" == linux* ]]; then
    tm='--time=atime'
  fi

  # lazily expand ll, because ls can be aliased later
  eval cd $1 && pwd && eval ll -tr $tm
}

# git
alias ga='git add'
alias gb='git branch'
alias gbd='git branch -d'
alias gc='git commit'
alias gcm='git commit -m'
alias go='git checkout'
alias gob='git checkout -b'
alias gom='git checkout master'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdu='git diff --diff-filter=U'  # show only unmerged diffs
alias gdh='git diff HEAD'
alias gl='git log'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge'
alias gp='git pull'
alias gs='git status'
alias gss='git status -s'

# plugins
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-completions"

zplug load
