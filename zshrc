# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list ''
zstyle :compinstall filename '/Users/gmathews/.zshrc'

fpath=(~/.zsh/completion $fpath)

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -v
# End of lines configured by zsh-newuser-install

# Make some commands more useful
alias ls='ls -G'
alias grep='grep --color=always'
export GREP_COLOR='1;37;47'

# Use vim
export EDITOR=vim
export VISUAL=vim
# Nice prompt
export PURE_PROMPT_SYMBOL=💰
autoload -U promptinit; promptinit
prompt pure

alias mux="tmuxinator"

# Search current history
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

USER_BASE_PATH=$(python3 -m site --user-base)
export PATH=/usr/local/opt/ruby/bin:$PATH:$USER_BASE_PATH/bin:~/.composer/vendor/bin
export PATH="/usr/local/opt/mysql-client@5.7/bin:$PATH"

export DOCKER_BUILDKIT=1

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
