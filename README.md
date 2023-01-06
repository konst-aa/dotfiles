in dotfiles folder, call `bash symlinks.sh`
profit

Notes:  
`symlinks.sh` symlinks the system-specific folder to ~/.current-os, then the current-os' config to ~/.config  
then it'll call its `setup.sh`, but ngl it's kinda redundant.
