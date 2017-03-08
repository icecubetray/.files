#.files
Some of my configuration files. Below I specified where each file is located on my systems and what packages/files they (optionally) depend on.

##.bashrc
Property | Value
---|---
Location | ~
Dependencies | **bashrc.sh**

##.xinitrc
Property | Value
---|---
Location | ~
Dependencies | **numlockx**, **redshift**, **enlightenment**

##bashrc.sh
Property | Value
---|---
Location | ~/Scripts
Dependencies | **bashrc.func.sh**

##bashrc.func.sh
Property | Value
---|---
Location | ~/Scripts
Dependencies | *function-dependent*

##codeblocks_theme.conf
Property | Value
---|---
Location | *import using CB shared config*
Dependencies | **codeblocks**
