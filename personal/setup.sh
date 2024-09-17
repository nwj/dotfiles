#!/bin/bash

WORKING_DIRECTORY=$(pwd)
XDG_CONFIG_HOME=$HOME/.config

mkdir -p "$XDG_CONFIG_HOME/alacritty"
ln -sf "$WORKING_DIRECTORY/alacritty/alacritty.toml" "$XDG_CONFIG_HOME/alacritty/alacritty.toml"

mkdir -p "$XDG_CONFIG_HOME/git"
ln -sf "$WORKING_DIRECTORY/git/config" "$XDG_CONFIG_HOME/git/config"

mkdir -p "$XDG_CONFIG_HOME/nvim"
ln -sf "$WORKING_DIRECTORY/nvim/init.lua" "$XDG_CONFIG_HOME/nvim/init.lua"
ln -sfn "$WORKING_DIRECTORY/nvim/autoload" "$XDG_CONFIG_HOME/nvim/autoload"

mkdir -p "$XDG_CONFIG_HOME/tmux"
ln -sf "$WORKING_DIRECTORY/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"

ln -sf "$WORKING_DIRECTORY/zsh/zshenv" "$HOME/.zshenv"
mkdir -p "$XDG_CONFIG_HOME/zsh"
ln -sf "$WORKING_DIRECTORY/zsh/zshrc" "$XDG_CONFIG_HOME/zsh/.zshrc"

mkdir -p "$XDG_CONFIG_HOME/fish"
ln -sf "$WORKING_DIRECTORY/fish/config.fish" "$XDG_CONFIG_HOME/fish/config.fish"
