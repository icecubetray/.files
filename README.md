#.files
Some of my configuration files. Below I specified where each file is located on my systems and what packages/files they (optionally) depend on.

##My setup
Property | Value
---|---
Laptop | Custom Lenovo ThinkPad E550
Operating System | [Arch Linux](https://www.archlinux.org/) (x64) :heart:
Window Manager | X11 + Enlightenment
Shell | Bash + Terminator

###.bashrc
Property | Value
---|---
Location | ~
Dependencies | **bashrc.sh**

###.xinitrc
Property | Value
---|---
Location | ~
Dependencies | **numlockx**, [**redshift**](http://jonls.dk/redshift/), [**enlightenment**](https://www.enlightenment.org/)

###bashrc.sh
Property | Value
---|---
Location | ~/Scripts
Dependencies | `ROOT`, `VERBOSE`, `BASHRC_SCRIPT_DIR`, **bashrc.func.sh**

###bashrc.func.sh
Property | Value
---|---
Location | ~/Scripts
Dependencies | `ROOT`, `VERBOSE`, *function-dependent*

###codeblocks_theme.conf
Property | Value
---|---
Location | *import using CB shared config*
Dependencies | [**codeblocks**](http://www.codeblocks.org/)
