# Dotfiles

### by nwj

Various configuration files (aka dotfiles) for my Unix-based systems.

### Installation

When setting up a new system, I usually follow a few steps:

1.  Clone this repo to a folder in home: `git clone https://github.com/nwj/dotfiles.git`
2.  Run the setup script to soft link configuration files out into the file system: `cd personal && ./setup.sh`
3.  Source shell config or start a new shell session, so that relevant updates there are recognized

This approach has a few advantages:

1.  No need to commit the entire home folder to a repo.
2.  Each configuration file is only used if it is soft linked.
3.  Changes made to a configuration file link back to the repo and can be managed through git as usual.
