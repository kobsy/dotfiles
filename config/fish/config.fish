# Increase the number of allowed open files
ulimit -Hn 200000
ulimit -Sn 65536

# EP Toolchain
if test -e ~/.ep/bin/ep
  eval (~/.ep/bin/ep init - fish)
end

# Rbenv Config
if test -n "$BOXEN_HOME"
  set -x RBENV_ROOT "$BOXEN_HOME/rbenv"
  source (rbenv init -|psub)
end

# Nodenv Config
if which nodenv > /dev/null
  status --is-interactive; and . (nodenv init -|psub)
end

# Set default editor
set -x VISUAL nvim
set -x EDITOR "$VISUAL"

# Add some override shims to PATH
if test -d ~/.override_shims
  set -x PATH ~/.override_shims $PATH
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
