fish_config theme choose "Dracula Official"

# EP Toolchain
if test -e ~/.ep/bin/ep
    set -x PROJECTS_PATH "$HOME/Code"
    eval (~/.ep/bin/ep init - fish)
else
    source ~/.config/fish/aliases.fish
end

# Homebrew on M1 Macs
if test -e /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

# Rbenv Config
if test -d "$HOME/.rbenv"
    set -x RBENV_ROOT "$HOME/.rbenv"
    status --is-interactive; and source (rbenv init -|psub)
end

# Nodenv Config
if which nodenv >/dev/null
    status --is-interactive; and source (nodenv init -|psub)
end

# Pyenv Config
if test -n "$PYENV_ROOT"
    set -x PYENV_ROOT "$HOME/.pyenv"
    set -x PATH "$PYENV_ROOT/bin" $PATH
end
if which pyenv >/dev/null
    status --is-interactive; and . (pyenv init -|psub)
end

# Allow finding the subl commmand
set -x PATH $PATH /Applications/Sublime\ Text.app/Contents/SharedSupport/bin

# Preempt the path for postgres CLI tools
if test -d /Applications/Postgres.app/Contents/Versions/latest/bin
    set -x PATH /Applications/Postgres.app/Contents/Versions/latest/bin $PATH
end

# Add rust to the path
if test -d ~/.cargo/bin
    set -x PATH ~/.cargo/bin $PATH
end

# Have fzf use ripgrep by default
set -gx FZF_DEFAULT_COMMAND "rg --files --hidden"

# Set default editor
set -x VISUAL nvim
set -x EDITOR "$VISUAL"

# Add some override shims to PATH
if test -d ~/.override_shims
    set -x PATH ~/.override_shims $PATH
end

# Add local python bin to PATH
if test -d ~/.local/bin
    set -x PATH ~/.local/bin $PATH
end

# Make cd to common directories easier
set -x CDPATH . ~ ~/Sites ~/Code ~/Documents

# Avoid a weird OBJC error with Ruby
set -x OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES

test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
set -g fish_user_paths "/usr/local/opt/postgresql@11/bin" $fish_user_paths

# pnpm
set -gx PNPM_HOME /Users/kobsmc/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# For tmux-clima; credentials stored in 1Password
if test -z "$OPEN_WEATHER_API_KEY" && which op >/dev/null
    set -x OPEN_WEATHER_API_KEY (op item get b55fuwastwi5urgkljkbu73cqu --reveal --field credential --account BNZ3QABYSJBVJBHWEQQSE6MKRE)
end
