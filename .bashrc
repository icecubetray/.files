#
# ~/.bashrc
#



# If not running interactively, don't do anything
if [[ $- != *i* ]]; then
	return;
fi;



export LESS_TERMCAP_mb=$'\E[01;36m';
export LESS_TERMCAP_md=$'\E[01;36m';
export LESS_TERMCAP_me=$'\E[0m';
export LESS_TERMCAP_se=$'\E[0m';
export LESS_TERMCAP_so=$'\E[01;44;33m';
export LESS_TERMCAP_ue=$'\E[0m';
export LESS_TERMCAP_us=$'\E[01;37m';



shopt -s checkwinsize;



export HISTCONTROL=ignoredups;
shopt -s histappend;
history -a;



source "$HOME/.bash_aliases";
source "$HOME/.bash_functions";

export GIT_PROMPT=1;
source "$HOME/.bash_prompt";


if [ -f "$HOME/.bash_custom" ]; then
	source "$HOME/.bash_custom";
fi;
