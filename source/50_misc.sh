# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export GREP_OPTIONS='--color=auto'

# Prevent less from clearing the screen while still showing colors.
export LESS=-asrRix8

# Set the terminal's title bar.
function titlebar() {
  echo -n $'\e]0;'"$*"$'\a'
}

# SSH auto-completion based on entries in known_hosts and config.
_complete_ssh_hosts ()
{
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                        cut -f 1 -d ' ' | \
                        sed -e s/,.*//g | \
                        grep -v ^# | \
                        uniq | \
                        grep -v "\[" ;
                cat ~/.ssh/config | \
                        grep --ignore-case "^Host " | \
                        awk '{print $2}'
                `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}
complete -F _complete_ssh_hosts ssh scp sftp

# Disable ansible cows }:]
export ANSIBLE_NOCOWS=1

#some alias'
alias pwgen='pwgen -1 -c -n -y 12'
alias sshchk='grep ~/.ssh/config -e'
alias edithosts='sudo vim /etc/hosts'
alias curlheaders='curl -vso /dev/null'
alias certpaste='pbpaste|certdownloader'
alias vgr='vagrant halt && vagrant up'
alias vgrf='vagrant halt --force && vagrant up'
alias vgh='vagrant halt'
alias vghf='vagrant halt --force'
alias sublfolder='subl -n -a .'
