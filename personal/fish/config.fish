# XDG
set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux XDG_DATA_HOME $HOME/.local/share
set -Ux XDG_STATE_HOME $HOME/.local/state
set -Ux XDG_CACHE_HOME $HOME/.cache

# Homebrew
eval (/opt/homebrew/bin/brew shellenv)

# Rust
set -Ux RUSTUP_HOME $XDG_CONFIG_HOME/rustup
set -Ux CARGO_HOME $XDG_CONFIG_HOME/cargo
fish_add_path $CARGO_HOME/bin

# Personal Scripts
fish_add_path $HOME/.local/bin

# Vim
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -U fish_key_bindings fish_vi_key_bindings

# Abbreviations
abbr ll 'eza --long --git --color-scale --group-directories-first'
abbr la 'eza --all --group-directories-first'
abbr lla 'eza --long --git --color-scale --group-directories-first --all'
abbr tree 'eza --tree --group-directories-first'
abbr ltree 'eza --tree --long --git --color-scale --group-directories-first'

# Disable fish greeting
set -U fish_greeting
