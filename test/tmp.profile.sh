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
                        grep "^Host " | \
                        awk '{print $2}'
                `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}
complete -F _complete_ssh_hosts ssh

# TODO make this more generic

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

_git_prompt='$(__git_ps1)'
git_prompt_locations=(
    /usr/local/Cellar/git/*/etc/bash_completion.d/git-prompt.sh
    /etc/bash_completion.d/git
    /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh
)
for f in "${git_prompt_locations[@]}"
do
    [[ -f $f ]] && {
        source "$f"
        break
    }
done
unset f
type __git_ps1 >&/dev/null || _git_prompt=''

if [ "$color_prompt" = yes ]; then
    if [ "$UID" -eq 0 ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]'$_git_prompt'$ '
#        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]$(__git_ps1)\$ '
    else
#        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]$(__git_ps1)\$ '
#        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@workstation\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]$(__git_ps1)\$ '
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]'$_git_prompt'$ '
    fi
else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1)\$ '
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w'$_git_prompt'$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac




#Adding path

    export PATH="/Users/cloh/.local/bin:$PATH"

alias ll='ls -l'
alias sshchk='grep ~/.ssh/config -e'
alias edithosts='sudo vim /etc/hosts'
source ~/.local/bin/bashmarks.sh

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

