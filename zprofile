# Homebrew first in PATH, so brew's python3 wins over macOS /usr/bin/python3 (3.9)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
