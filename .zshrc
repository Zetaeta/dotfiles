# Lines configured by zsh-newuser-install
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/daniel/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Path to your oh-my-zsh configuration.
ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster-zeta"
#ZSH_THEME="zetaeta"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

bindkey -v
 bindkey "^W" backward-kill-word    # vi-backward-kill-word
 bindkey "^H" backward-delete-char  # vi-backward-delete-char
 bindkey "^U" kill-line             # vi-kill-line
 bindkey "^?" backward-delete-char  # vi-backward-delete-char

unalias sl

alias rawsu=su
alias su='su -'

alias youtube-mp3='youtube-dl -t --extract-audio --audio-format mp3 --audio-quality 320k'

MCPP="/home/daniel/Programming/C++/MC++-Server"
export XDG_CONFIG_HOME="/home/daniel/.config"

# Customize to your needs...
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
unsetopt correctall
autoload edit-command-line
zle -N edit-command-line
bindkey -a v edit-command-line
SAVEHIST=20000
HISTFILE="~/.zsh_history"
