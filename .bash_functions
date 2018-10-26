extract () {
	if [ -z $1 ] ; then
		echo "Usage: extract <files>";
	else
		if [ -f $1 ] ; then
			case $1 in
				*.tar.bz2)	tar xvjf $1		;;
				*.tar.gz)	tar xvzf $1		;;
				*.tar.xz)	tar xvfJ $1		;;
				*.bz2)		bunzip2 $1		;;
				*.rar)		unrar x $1		;;
				*.gz)		gunzip $1		;;
				*.tar)		tar xvf $1		;;
				*.tbz2)		tar xvjf $1		;;
				*.tgz)		tar xvzf $1		;;
				*.zip)		unzip $1		;;
				*.Z)		uncompress $1	;;
				*.7z)		7z x $1			;;
				*)			echo "Cannot extract: $1" ;;
			esac
		else
			echo "File not found: $1"
		fi
	fi
}

mkcd() {
	if [ $# != 1 ]; then
		echo "Usage: mkcd <dir>"
	else
		mkdir -p $1 && cd $1
	fi
}

disasm() {
	if [ $# != 2 ] ; then
		return 1;
	fi

	gdb -batch -ex "file '$1'" -ex "disassemble '$2'";
}

touchc() {
	for arg in "$@"; do
		touch "$arg"{.c,.h};
		echo "$arg.c $arg.h";
	done;
}

mvc() {
	if [ $# -ne 2 ]; then
		return 1;
	else
		if [ -f "$1.h" ]; then
			mv "$1.h" "$2.h";
		fi;
		if [ -f "$1.c" ]; then
			mv "$1.c" "$2.c";
		fi;
	fi;
}
