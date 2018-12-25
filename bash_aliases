less_a(){
 less $1
}

install_a(){
 sudo apt-get install $1
}

search_a(){
 sudo apt-cache search $1
}

pdf_a(){
 evince $1
}

ss_a(){
  ssh-keygen -f "/home/os/.ssh/known_hosts" -R $1 
  ssh -oStrictHostKeyChecking=no $1 -l root
}

ffind(){
  find . -name "$@"
}

lpass_a(){
  #Select and copy password to clipboard from lastpass
  lpass show -c --password $(lpass ls  | fzf | awk '{print $(NF)}' | sed 's/\]//g')
}

vs(){
    #List all vagrant boxes available in the system including its status, and try to access the selected one via ssh
    cd $(cat ~/.vagrant.d/data/machine-index/index | jq '.machines[] | {name, vagrantfile_path, state}' | jq '.name + "," + .state  + "," + .vagrantfile_path'| sed 's/^"\(.*\)"$/\1/'| column -s, -t | sort -rk 2 | fzf | awk '{print $3}'); vagrant ssh
}

alias dus='du -s * | sort -nr | cut -f2 | xargs du -sh'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -alF'
alias ll='ls -l'
alias ls='ls --color=auto'
alias o='less_a'
alias xmlout='tidy -xml -i -m $1'
alias lps="ps auxf"
alias pdf='pdf_a'
alias cdw='cd /home/os/work'
alias cdj='cd /home/os/work/java/projects'
alias install='install_a'
alias search='search_a'
alias addk='ssh-add /home/os/.ssh/identity'
alias ..='cd ..'
alias tm='tmux -2 attach || tmux -2 new'
alias ss='ss_a'
alias h='history | sed -r "s/\s+/ /g" | cut -d " " -f3-'
alias psm='ps -e -orss=,args= | sort -b -k1,1n | pr -TW$COLUMNS'
alias k='kubectl'
alias kk='kubectl get all'
alias wk='watch -n 1 kubectl get all'
alias ka='kubectl get all --all-namespaces'
alias kc='kubectl create -f'
alias kdel='kubectl delete -f'
alias kcdel='kubectl delete configmap'
alias kd='kubectl describe'
alias kl='kubectl logs'
alias lp='lpass_a'
