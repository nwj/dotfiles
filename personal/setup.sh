#!/bin/bash

WORKING_DIRECTORY=$(pwd)
XDG_CONFIG_HOME=$HOME/.config

mkdir -p "$XDG_CONFIG_HOME/ghostty"
ln -sf "$WORKING_DIRECTORY/ghostty/config" "$XDG_CONFIG_HOME/ghostty/config"

mkdir -p "$XDG_CONFIG_HOME/git"
ln -sf "$WORKING_DIRECTORY/git/config" "$XDG_CONFIG_HOME/git/config"

mkdir -p "$XDG_CONFIG_HOME/nvim"
ln -sf "$WORKING_DIRECTORY/nvim/init.lua" "$XDG_CONFIG_HOME/nvim/init.lua"
ln -sfn "$WORKING_DIRECTORY/nvim/autoload" "$XDG_CONFIG_HOME/nvim/autoload"

mkdir -p "$XDG_CONFIG_HOME/fish"
ln -sf "$WORKING_DIRECTORY/fish/config.fish" "$XDG_CONFIG_HOME/fish/config.fish"
