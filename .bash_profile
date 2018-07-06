#
# ~/.bash_profile
#

if [ -f ~/.bashrc ]; then
	source ~/.bashrc;
fi;

echo -e "\x1B[0;37mAutostart X?\x1B[0m" && sleep 3s;
if [ $? -eq 0 ]; then
	startx > ~/x.log 2> ~/x.err.log
fi;
