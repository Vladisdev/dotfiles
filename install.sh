#!/usr/bin/env bash
# Deploy dotfiles with GNU Stow. Existing files are moved to a dated backup first.
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
backup_dir="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
packages=(zsh git lazygit nvim)
targets=("$HOME/.zshrc" "$HOME/.p10k.zsh" "$HOME/.gitconfig" "$HOME/.config/lazygit" "$HOME/.config/nvim")

command -v stow >/dev/null 2>&1 || {
  echo 'GNU Stow is missing. Run: sudo apt install stow'
  exit 1
}

for target in "${targets[@]}"; do
  if [[ -e "$target" && ! -L "$target" ]]; then
    mkdir -p "$backup_dir"
    relative="${target#$HOME/}"
    mkdir -p "$backup_dir/$(dirname -- "$relative")"
    mv "$target" "$backup_dir/$relative"
    echo "Backed up $target"
  fi
done

cd "$repo_dir"
stow --restow --target="$HOME" "${packages[@]}"

echo 'Dotfiles deployed.'
[[ -d "$backup_dir" ]] && echo "Previous files: $backup_dir"
echo 'Open a new terminal, then run: nvim'
