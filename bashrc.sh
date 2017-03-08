#!/bin/bash

if [ $VERBOSE == 1 ]; then
	echo "bashrc.sh";
fi

export LESS_TERMCAP_mb=$'\E[01;36m'
export LESS_TERMCAP_md=$'\E[01;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;37m'

alias ls='ls -l --color=auto --group-directories-first'
alias nano='nano --tabsize=4 --autoindent --nowrap'
alias lsnet='netstat -pea | grep -e tcp -e udp -e udpl -e raw'
alias grep='grep --color=auto'
alias igrep='grep -v'
alias watch='watch -c'

shopt -s checkwinsize

export HISTCONTROL=ignoredups
shopt -s histappend
history -a

export PROMPT_COMMAND=__prompt_command
function __prompt_command() {
	local EXITCODE=$?
	local COLOR_EXITCODE=""

	if [ $EXITCODE != 0 ]; then
		COLOR_EXITCODE="\[\e[31;1m\]"
	else
		COLOR_EXITCODE="\[\e[32m\]"
	fi

	PS1="\[\e[0m\][$COLOR_EXITCODE`printf %3s $EXITCODE`\[\e[0m\]] "

	local COLOR_RESET="\[\e[0m\]"
	local COLOR_HOST="\[\e[35;1m\]"
	local COLOR_CWD="\[\e[37;1m\]"
	local COLOR_USER="";

	local COLOR_SUFFIX="\[\e[36m\]";
	local SUFFIX="";

	if [ $ROOT != 1 ]; then
		COLOR_USER="\[\e[34;1m\]"
		SUFFIX="\$"
	else
		COLOR_USER="\[\e[31;1m\]"
		SUFFIX="#"
	fi

	PS1+="$COLOR_USER\u$COLOR_RESET@$COLOR_HOST\h$COLOR_RESET:$COLOR_CWD\w$COLOR_RESET $COLOR_SUFFIX\$$COLOR_RESET "
}

. "$BASHRC_SCRIPT_DIR/bashrc.func.sh"
