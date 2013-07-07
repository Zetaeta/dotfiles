#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


#alias ls='ls -a --color=auto'
#alias grep='grep --color=auto'
#PS1='[\[\e[1;32m\]\u\[\e[1;30m\]@\[\e[1;31m\]\h\[\e[1;34m\] \w\[\e[m\]]\$ '
alias ..='cd ..'
alias serversrc='cd ~/Documents/Programming/C++/MC++-Server/'
export MCPP='/home/daniel/Documents/Programming/C++/MC++-Server/'

alias sudo="sudo " # command ending with a space checks the next word for aliases.

set -o vi

bind '"\e[1;5A":"cd ..\n"'
bind '"\e[1;5B":"meow"'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

HISTSIZE=10000
