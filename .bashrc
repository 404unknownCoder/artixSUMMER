#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias ls='ls --color=auto'
# alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '
#
/usr/local/bin/pfetch
history -c
if [ -f ~/.bash_aliases ]; then
       source ~/.bash_aliases
fi
export PS1="[\e[0;35m\u@\e[0;35m\h \e[0;35m\W]$\[\033[0m\] "
