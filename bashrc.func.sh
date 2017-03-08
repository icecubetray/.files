if [ $VERBOSE == 1 ]; then
	echo "bashrc.func.sh";
fi

extract () {
	if [ -z $1 ] ; then
		echo "Usage: extract <files>";
	else
		if [ -f $1 ] ; then
			case $1 in
				*.tar.bz2)   tar xvjf $1    ;;
				*.tar.gz)    tar xvzf $1    ;;
				*.bz2)       bunzip2 $1     ;;
				*.rar)       unrar x $1     ;;
				*.gz)        gunzip $1      ;;
				*.tar)       tar xvf $1     ;;
				*.tbz2)      tar xvjf $1    ;;
				*.tgz)       tar xvzf $1    ;;
				*.zip)       unzip $1       ;;
				*.Z)         uncompress $1  ;;
				*.7z)        7z x $1        ;;
				*)           echo "Cannot extract: $1" ;;
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

__ufw_setup_usage() {
	echo "Usage: ufw_setup [web|webplain|ssh|tox|git|whois]";
}
ufw_setup() {
	if [ $ROOT == 1 ] ; then
		if [ $# == 0 ] ; then
			__ufw_setup_usage;
		else
			case "$1" in
				dns)
					echo "TCP: 53";
					ufw allow out 53/tcp
					echo "UDP: 53";
					ufw allow out 53/udp
					;;
				web)
					ufw_setup dns;
					echo "TCP: 443";
					ufw allow out 443/tcp
					;;
				webplain)
					ufw_setup web;
					echo "TCP: 80";
					ufw allow out 80/tcp
					;;
				ssh)
					ufw_setup dns;
					echo "TCP: 22";
					ufw allow out 22/tcp
					;;
				tox)
					ufw_setup dns;
					echo "TCP: 443";
					ufw allow out 443/tcp
					echo "TCP: 3389";
					ufw allow out 3389/tcp
					echo "TCP: 33445";
					ufw allow out 33445/tcp
					;;
				git)
					ufw_setup dns;
					echo "TCP: 443";
					ufw allow out 443/tcp
					;;
				gitgit)
					ufw_setup dns;
					echo "TCP: 9418";
					ufw allow out 9418/tcp
					;;
				whois)
					ufw_setup dns;
					echo "TCP: 43";
					ufw allow out 43/tcp
					;;
				*)
					__ufw_setup_usage;
					return;
			esac
		fi
	else
		__ufw_setup_usage;
		echo "You need to be root.";
	fi
}

sysupgrade() {
	if [ $ROOT != 1 ] ; then
		return 1;
	fi
	printf "\033[37;1m=== Adding firewall rules. ===\033[0m\n"
	ufw allow out 80/tcp
	printf "\n\033[37;1m=== System upgrade. ===\033[0m\n"
	pacman -Syu
	printf "\n\033[37;1m=== Deleting firewall rules. ===\033[0m\n"
	ufw delete allow out 80/tcp
	printf "\n\033[37;1m=== Cleanup. ===\033[0m\n"
	pacman -Sc
	printf "\n\033[37;1m=== Done. ===\033[0m\n"
}

fixperms() {
	path=`readlink -e ~`
	if [ $# -gt 0 ] ; then
		path=`readlink -e $1`
	fi
	local PERM_DIR=700
	local PERM_FILE=644
	echo "The following changes will be committed if you continue:"
	echo "All directories in '$path' will be chmodded to $PERM_DIR."
	echo "All files in '$path' will be chmodded to $PERM_FILE."
	read -p "Are you sure you want to continue? (y/n): " -r -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]] ; then
		read -p "Are you very sure? (y/n): " -r -n 1
		echo
		if [[ $REPLY =~ ^[Yy]$ ]] ; then
			printf "Directories..."
			find $path -type d -print0 | xargs -0 chmod $PERM_DIR
			printf " done.\nFiles..."
			find $path -type f -print0 | xargs -0 chmod $PERM_FILE
			echo " done."
		else
			echo "Aborted."
		fi
	else
		echo "Aborted."
	fi
}

disasm() {
	if [ $# != 2 ] ; then
		return;
	fi

	gdb -batch -ex "file '$1'" -ex "disassemble '$2'";
}

