# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list ''
zstyle :compinstall filename '/Users/george/.zshrc'

fpath=(~/.zsh/completion $fpath)

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
setopt HIST_IGNORE_DUPS
HISTSIZE=10000
SAVEHIST=10000
bindkey -v
# End of lines configured by zsh-newuser-install

# Make some commands more useful
alias ls='ls -G'
alias grep='grep --color=always'
export GREP_COLOR='1;37;47'

# Use vim
export EDITOR=nvim
export VISUAL=nvim
# Nice prompt
export PURE_PROMPT_SYMBOL=💰
autoload -U promptinit; promptinit
prompt pure

alias mux="tmuxinator"

# Search current history
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
