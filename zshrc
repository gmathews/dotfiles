zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list ''
zstyle :compinstall filename '/Users/george/.zshrc'

fpath=(~/.zsh/completion $fpath)

autoload -Uz compinit
compinit

# Setup history
HISTFILE=~/.histfile
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
HISTSIZE=10000
SAVEHIST=10000
# cd **, kill **, ctrl+r history search
source <(fzf --zsh)

# Make some commands more useful
alias ls='ls --color'
alias grep='grep --color=always'
export GREP_COLOR='1;35;40'
alias diff='colordiff'
alias mux="tmuxinator"

# Use vim
bindkey -v
export EDITOR=nvim
export VISUAL=nvim

# Paths
export PATH="$HOMEBREW_PREFIX/opt/ncurses/bin:$PATH"
eval "$(fnm env --use-on-cd)"

# Search current history
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

git_clean_branches() {
    git fetch --prune
    git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
}

# Nice prompt
eval "$(starship init zsh)"

# Keep at the end
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
