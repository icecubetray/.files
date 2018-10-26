# Dotfiles
Some configuration files.

## Shells
Currently my configuration supports `zsh` and `bash`. I recently changed to `zsh`.<br/>
To enable, symlink `~/.${shell}rc` to `repo/shellrc/autoconfig` (ex. `ln -s git/dotfiles/shellrc/autoconfig .zshrc`).

## ssh-agent
By using [`shellrc/autoconfig`](shellrc/autoconfig), if you have `ssh-agent` installed, `ssh-agent` will be started once per user when they log in.<br/>
The `ssh-agent` instances will remain until the system gets shut down, or they're manually killed (see [`shellrc/handle-sshagent`](shellrc/handle-sshagent)).

## Git prompt
If you want to have it enabled on a per-repository basis, set `GIT_PROMPT_DEFAULT` to something other than `on` and set the configuration key `prompt.enabled` to `ice` to enable the prompt for that repository.
If you want to have it disabled on a per-repository basis, set `GIT_PROMPT_DEFAULT` to `on` and set the configuration key `prompt.enabled` to `no` to disable the prompt for that repository.
