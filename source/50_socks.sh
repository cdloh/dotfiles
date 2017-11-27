#
# socks command to start ssh proxy easily
#

function socks() {

	local usage="Usage: $0 [-h|--help] [SSH Target] [start|stop|status]"

	(($#)) || {
		ls ~/.ssh/ | grep socks
		return 0
	}

	case "$1" in
		start) ssh -M -S ~/.ssh/$2-socks -f -C2qTnN -D 8080 $2;;
		stop) ssh -S ~/.ssh/$2-socks -O exit $2;;
		status) ssh -S ~/.ssh/$2-socks -O check $2;;
		-h|--help) echo "$usage";;
		*) echo "Unknown command: $1"; echo "$usage" >&2; return 1;;
	esac

}

__socks_complete()
{
	local cur=${COMP_WORDS[COMP_CWORD]}
	if [ $COMP_CWORD -eq 1 ]; then
		COMPREPLY=( $(compgen -W "start stop status list help" -- $cur) )
	else
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
	fi
}
complete -F __socks_complete socks
