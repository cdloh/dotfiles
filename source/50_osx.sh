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

#export NVM_DIR="$HOME/.nvm"
#[ -s "$DOTFILES/vendor/nvm/nvm.sh" ] && . "$DOTFILES/vendor/nvm/nvm.sh" # This loads nvm

if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# Make 'less' more.
[[ "$(type -P lesspipe.sh)" ]] && eval "$(lesspipe.sh)"

# Better netstat
netstat() {
	if [[ "$1" = -tlpn ]]
	then
		netstat -anf inet | awk '$1 ~ /tcp/ && $NF == "LISTEN" { count = split($4, bits, "."); command = "lsof -nP -i:" bits[count] "| awk \"NR>1 && /LISTEN/ {print \\$2}\""; command | getline pid; $(NF+1) = pid; print}' | column -t
	else
		command netstat "$@"
	fi
}
export -f netstat

# Start ScreenSaver. This will lock the screen if locking is enabled.
alias imapfilter="screen -xRR -S imapfilter bash -c 'cd ~/.imapfilter; imapfilter -t /usr/local/etc/openssl/cert.pem -l ~/.imapfilter/imapfilter.log; exec bash'"
alias ss="open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"
alias eject="osascript -e 'tell application \"Finder\" to eject (every disk whose ejectable is true and local volume is true and free space is not equal to 0)'"
alias reloadmdns="sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist && sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist"
alias testssl="testssl --openssl ~/.dotfiles/vendor/testssl.sh/bin/openssl.Darwin.x86_64"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --disable-web-security --user-data-dir=$HOME/.chrome-no-security"
