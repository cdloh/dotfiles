function polipo() {
	local usage="Usage: $0 [-h|--help] [start|stop|status|purge|size]"

	(($#)) || {
		echo "$usage" >&2
		return 1
	}

	case "$1" in
		start) launchctl load -F ~/Library/LaunchAgents/homebrew.mxcl.polipo.plist;;
		stop) launchctl unload -F ~/Library/LaunchAgents/homebrew.mxcl.polipo.plist;;
		restart) launchctl unload -F ~/Library/LaunchAgents/homebrew.mxcl.polipo.plist && launchctl load -F ~/Library/LaunchAgents/homebrew.mxcl.polipo.plist;;
		status) launchctl list | grep polipo;;
		-h|--help) echo "$usage";;
		purge) kill -USR1 `pid /usr/local/opt/polipo/bin/polipo` && sleep 1 && /usr/local/bin/polipo -x && kill -USR2 `pid /usr/local/opt/polipo/bin/polipo`;;
		size) du -sh /usr/local/var/cache/polipo/;;
		*) echo "Unknown command: $1"; echo "$usage" >&2; return 1;;
	esac
}
#export -f polipo

