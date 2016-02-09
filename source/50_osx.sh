# OSX-only stuff. Abort if not OSX.
is_osx || return 1

if [ -d $(brew --prefix)/etc/bash_completion.d ]; then
	for f in $(brew --prefix)/etc/bash_completion.d/*; do
  	source $f  
	done
fi

# APPLE, Y U PUT /usr/bin B4 /usr/local/bin?!
PATH="/usr/local/bin:~/bin:$(path_remove /usr/local/bin)"
PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH

if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# Make 'less' more.
[[ "$(type -P lesspipe.sh)" ]] && eval "$(lesspipe.sh)"

# Start ScreenSaver. This will lock the screen if locking is enabled.
alias ss="open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"
alias eject="osascript -e 'tell application \"Finder\" to eject (every disk whose ejectable is true and local volume is true and free space is not equal to 0)'"
