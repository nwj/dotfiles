# XDG
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_CACHE_HOME $HOME/.cache

# Homebrew
eval (/opt/homebrew/bin/brew shellenv)

# Rust
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
fish_add_path -g $CARGO_HOME/bin

# Personal Scripts
fish_add_path -g $HOME/.local/bin

# Editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Abbreviations
abbr ll 'eza --long --git --color-scale --group-directories-first'
abbr la 'eza --all --group-directories-first'
abbr lla 'eza --long --git --color-scale --group-directories-first --all'
if status is-interactive
    fish_vi_key_bindings

    # Disable fish greeting
    set -g fish_greeting

    # Zoxide
    type -q zoxide; and zoxide init fish | source

    # Configure the tide prompt, if it hasn't been already (e.g. on a fresh install)
    if type -q tide; and not set -q tide_left_prompt_items
        tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='One line' --prompt_spacing=Sparse --icons='Few icons' --transient=No
    end

    # Abbreviations
    abbr ll 'eza --long --git --color-scale --group-directories-first'
    abbr la 'eza --all --group-directories-first'
    abbr lla 'eza --long --git --color-scale --group-directories-first --all'
    abbr tree 'eza --tree --group-directories-first'
    abbr ltree 'eza --tree --long --git --color-scale --group-directories-first'
end
