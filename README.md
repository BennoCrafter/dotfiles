# dotfiles

My mac setup.

## new mac

```sh
xcode-select --install          # git
git clone https://github.com/BennoCrafter/dotfiles ~/dotfiles
sh ~/dotfiles/scripts/install.sh
```

## Files

| File | What |
|---|---|
| `Brewfile` | apps and CLI tools |
| `zprofile` → `~/.zprofile` | PATH: Homebrew first, so `python3` is brew's, not macOS 3.9 |
| `zshrc` → `~/.zshrc` | aliases, prompt |
| `gitconfig` → `~/.gitconfig` | git user and settings |
| `scripts/macos.sh` | System Settings via `defaults write`, Dock, wallpaper |
| `dock-apps.txt` | Dock apps in order (one path per line) |
| `config/zed/` → `~/.config/zed/` | Zed settings and keymap |
| `scripts/update.sh` | save current Brewfile + Dock order into the repo |
| `wallpaper/` | wallpapers |

## Keep it current

After installing apps or rearranging the Dock: `sh ~/dotfiles/scripts/update.sh`, then commit.

## Manual steps

- [ ] Sign into iCloud / App Store
