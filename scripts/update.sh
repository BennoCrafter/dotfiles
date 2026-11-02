#!/bin/sh
# save the current Mac state into the repo: installed apps and dock order
set -e
DOT="$HOME/dotfiles"

brew bundle dump --force --file="$DOT/Brewfile"
sed -i '' 's/^brew "python@[0-9.]*"/brew "python"/' "$DOT/Brewfile"  # track newest python, not a pinned version

defaults export com.apple.dock - | python3 -c '
import plistlib, sys, urllib.parse
for tile in plistlib.loads(sys.stdin.buffer.read())["persistent-apps"]:
    url = tile["tile-data"]["file-data"]["_CFURLString"]
    print(urllib.parse.unquote(url.removeprefix("file://")).rstrip("/"))
' > "$DOT/dock-apps.txt"

echo "Updated Brewfile and dock-apps.txt. Review with: git -C $DOT diff"
