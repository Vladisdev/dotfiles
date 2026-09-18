#!/usr/bin/env bash
# Installs the command-line prerequisites for this repository on Ubuntu 24.04+.
# Docker is intentionally separate: see docs/WORKSTATION.md.
set -euo pipefail

if [[ "${EUID}" -eq 0 ]]; then
  echo 'Run this as your normal WSL user; the script invokes sudo when required.' >&2
  exit 1
fi

sudo apt-get update
sudo apt-get install -y \
  bash-completion build-essential ca-certificates curl fd-find file fzf git gnupg \
  jq make ripgrep stow tmux tree unzip wget xclip xsel zoxide zsh

mkdir -p "$HOME/.local/bin" "$HOME/.local/opt" "$HOME/.config"
if [[ -x /usr/bin/fdfind && ! -e "$HOME/.local/bin/fd" ]]; then
  ln -s /usr/bin/fdfind "$HOME/.local/bin/fd"
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi
for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
  destination="$HOME/.oh-my-zsh/custom/plugins/$plugin"
  [[ -d "$destination" ]] || git clone --depth=1 "https://github.com/zsh-users/$plugin.git" "$destination"
done
theme_dir="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
[[ -d "$theme_dir" ]] || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$theme_dir"

export NVM_DIR="$HOME/.config/nvm"
mkdir -p "$NVM_DIR"
if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | PROFILE=/dev/null bash
fi
# shellcheck disable=SC1091
source "$NVM_DIR/nvm.sh"
nvm install --lts
nvm alias default 'lts/*'

install_dir="$HOME/.local/opt/go"
if [[ ! -x "$install_dir/bin/go" ]]; then
  go_version="$(curl -fsSL 'https://go.dev/VERSION?m=text' | head -n1)"
  case "$(dpkg --print-architecture)" in
    amd64) go_arch='amd64' ;;
    arm64) go_arch='arm64' ;;
    *) echo 'Unsupported CPU architecture for automatic Go installation.' >&2; exit 1 ;;
  esac
  archive="$(mktemp --suffix=.tar.gz)"
  curl -fL "https://go.dev/dl/${go_version}.linux-${go_arch}.tar.gz" -o "$archive"
  temp_dir="$(mktemp -d)"
  tar -xzf "$archive" -C "$temp_dir"
  rm -f "$archive"
  [[ -e "$install_dir" ]] && mv "$install_dir" "${install_dir}.backup-$(date +%Y%m%d-%H%M%S)"
  mv "$temp_dir/go" "$install_dir"
  rmdir "$temp_dir"
fi

if [[ ! -x "$HOME/.local/bin/nvim" ]]; then
  archive="$(mktemp --suffix=.tar.gz)"
  curl -fL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz -o "$archive"
  temp_dir="$(mktemp -d)"
  tar -xzf "$archive" -C "$temp_dir"
  rm -f "$archive"
  nvim_dir="$HOME/.local/opt/nvim-linux-x86_64"
  [[ -e "$nvim_dir" ]] && mv "$nvim_dir" "${nvim_dir}.backup-$(date +%Y%m%d-%H%M%S)"
  mv "$temp_dir/nvim-linux-x86_64" "$nvim_dir"
  rmdir "$temp_dir"
  ln -s "$nvim_dir/bin/nvim" "$HOME/.local/bin/nvim"
fi

if [[ ! -x "$HOME/.local/bin/lazygit" ]]; then
  lazygit_version="$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest | jq -r .tag_name)"
  case "$(dpkg --print-architecture)" in
    amd64) lazygit_arch='x86_64' ;;
    arm64) lazygit_arch='arm64' ;;
    *) echo 'Unsupported CPU architecture for automatic LazyGit installation.' >&2; exit 1 ;;
  esac
  archive="$(mktemp --suffix=.tar.gz)"
  curl -fL "https://github.com/jesseduffield/lazygit/releases/download/${lazygit_version}/lazygit_${lazygit_version#v}_Linux_${lazygit_arch}.tar.gz" -o "$archive"
  tar -xzf "$archive" -C "$HOME/.local/bin" lazygit
  rm -f "$archive"
fi

echo 'Bootstrap complete. Next: ./install.sh, then exec zsh -l'
