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
if which rbenv >/dev/null
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

# Add rust to the path
if test -e ~/.cargo/bin
    set -x PATH ~/.cargo/bin $PATH
end

# Have fzf use ripgrep by default
set -gx FZF_DEFAULT_COMMAND "rg --files --hidden"

# Set default editor
set -x VISUAL nvim
set -x EDITOR "$VISUAL"

# Add some override shims to PATH
if test -e ~/.override_shims
    set -x PATH ~/.override_shims $PATH
end

# Add local python bin to PATH
if test -e ~/.local/bin
    set -x PATH ~/.local/bin $PATH
end

# Make cd to common directories easier
set -x CDPATH . ~ ~/Sites ~/Code ~/Documents

# Avoid a weird OBJC error with Ruby
set -x OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES

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

if test -f ~/.orbstack/shell/init2.fish
    # Added by OrbStack: command-line tools and integration
    # This won't be added again if you remove it.
    source ~/.orbstack/shell/init2.fish 2>/dev/null || :
end
