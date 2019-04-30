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
alias mux="tmuxinator"
# Use vim
export EDITOR=vim
export VISUAL=vim
# Nice prompt
autoload -U promptinit; promptinit
prompt pure

# VIM_PROMPT="❯"
# PROMPT='%(?.%F{magenta}.%F{red})${VIM_PROMPT}%f '
#
# prompt_pure_update_vim_prompt() {
#     zle || {
#         print "error: pure_update_vim_prompt must be called when zle is active"
#         return 1
#     }
#     VIM_PROMPT=${${KEYMAP/vicmd/❮}/(main|viins)/❯}
#     zle .reset-prompt
# }
#
# function zle-line-init zle-keymap-select {
#     prompt_pure_update_vim_prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select

# Search current history
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

USER_BASE_PATH=$(python3 -m site --user-base)
export PATH=$PATH:$USER_BASE_PATH/bin:~/.composer/vendor/bin

if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

