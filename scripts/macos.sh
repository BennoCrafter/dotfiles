#!/bin/sh
# macOS system settings. Find keys: defaults read > a; change setting; defaults read > b; diff a b

# Trackpad: natural scrolling off
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Trackpad: right click = click in bottom right corner (both built-in and Bluetooth trackpads)
for d in com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad; do
  defaults write $d TrackpadCornerSecondaryClick -int 2
  defaults write $d TrackpadRightClick -bool false
done

# Dock: auto-hide, no delay, faster animation
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -int 0
defaults write com.apple.dock autohide-time-modifier -float 0.7

# Dock: don't show suggested and recent apps
defaults write com.apple.dock show-recents -bool false

# dock: only the apps in dock-apps.txt, in order (missing apps are skipped). Refresh with scripts/update.sh
defaults write com.apple.dock persistent-apps -array
while IFS= read -r app; do
  [ -e "$app" ] || { echo "Dock: skipping missing $app"; continue; }
  defaults write com.apple.dock persistent-apps -array-add \
    "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done < "$HOME/dotfiles/dock-apps.txt"

# stage Manager on
defaults write com.apple.WindowManager GloballyEnabled -bool true

# finder: new windows open the home folder
defaults write com.apple.finder NewWindowTarget -string PfHm
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/"

# set wallpaper on every display
osascript -e "tell application \"System Events\" to tell every desktop to set picture to POSIX file \"$HOME/dotfiles/wallpaper/1.png\""

killall Dock Finder WindowManager 2>/dev/null || true
echo "macOS settings applied. Log out and back in for the trackpad settings."
