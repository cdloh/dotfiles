function polipo() {
	local usage="Usage: $0 [-h|--help] [start|stop|status]"

	(($#)) || {
		echo "$usage" >&2
		return 1
	}

	case "$1" in
		start) launchctl load -F ~/Library/LaunchAgents/homebrew.mxcl.polipo.plist;;
		stop) launchctl unload -F ~/Library/LaunchAgents/homebrew.mxcl.polipo.plist;;
		status) launchctl list | grep polipo;;
		-h|--help) echo "$usage";;
		*) echo "Unknown command: $1"; echo "$usage" >&2; return 1;;
	esac
}
export -f polipo

