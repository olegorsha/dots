# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export HISTCONTROL=ignoreboth
export HISTIGNORE="&:ls:[bf]g:exit:history:mc:man:h"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

[ -f /etc/bash_completion ] && . /etc/bash_completion
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.kube/completion.bash.inc ] && . ~/.kube/completion.bash.inc
[ -f ~/.helm/completion.bash.inc ] && . ~/.helm/completion.bash.inc
[ -f ~/.promptline.sh ] && . ~/.promptline.sh

export EDITOR=/usr/bin/vim
export PAGER=less

shopt -s checkwinsize
shopt -s histappend                      # append to history, don't overwrite it

# make and change to a directory
md () { mkdir -p "$1" && cd "$1"; }

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

shopt -s cdspell
shopt -s cmdhist

set -o pipefail
stty ixoff -ixon # disable Ctrl-S Ctrl-Q
curl -s -d "lang=ru&method=getQuote&format=text" http://api.forismatic.com/api/1.0/
echo ""

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    (umask 066; /usr/bin/ssh-agent > "${SSH_ENV}")
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
}
else
    start_agent;
fi 

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/os/.sdkman"
[[ -s "/home/os/.sdkman/bin/sdkman-init.sh" ]] && source "/home/os/.sdkman/bin/sdkman-init.sh"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/

export PATH=$PATH:/snap/bin
