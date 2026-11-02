#!/bin/sh
set -e
DOT="$HOME/dotfiles"

if ! [ -x /opt/homebrew/bin/brew ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file="$DOT/Brewfile"

for f in zprofile zshrc gitconfig; do
  target="$HOME/.$f"
  [ -e "$target" ] && ! [ -L "$target" ] && mv "$target" "$target.backup"
  ln -sf "$DOT/$f" "$target"
done

sh "$DOT/scripts/macos.sh"
echo "Done. Open a new terminal. See README.md for manual steps."
