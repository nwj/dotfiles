#Dotfiles
###by nwj

Various configuration files (aka dotfiles) for my Unix-based systems.

###Installation
When setting up a new system, I usually follow a few steps:

1.  Clone this repo to a folder in home: `git clone https://github.com/nwj/dotfiles.git`
2.  Soft link the configuration files I need out into the file system: `ln -s ~/dotfiles/vimrc ~/.vimrc`
3.  In some cases, it is necessary to restart or re-source after certain files are changed. For example, `source .bashrc`

This approach has a few advantages:

1.  No need to commit the entire home folder to a repo.
2.  Each configuration file is only used if it is soft linked. I can pick and choose what is necessary for each system.
3.  Changes made to a configuration file link back to the repo and can be managed through git as usual.
