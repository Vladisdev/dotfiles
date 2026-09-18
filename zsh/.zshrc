# Managed by ~/dotfiles. Machine- or project-specific values belong in ~/.zshrc.local.

# Keep this before Oh My Zsh: it makes new shells feel instant.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

if [[ -d "$ZSH" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# User-installed programs take priority over system packages.
export PATH="$HOME/.local/bin:$PATH"

# Go is installed by scripts/bootstrap-ubuntu.sh into ~/.local/opt/go.
if [[ -d "$HOME/.local/opt/go/bin" ]]; then
  export PATH="$HOME/.local/opt/go/bin:$PATH"
elif [[ -d "/usr/local/go/bin" ]]; then
  export PATH="/usr/local/go/bin:$PATH"
fi
export GOPATH="${GOPATH:-$HOME/go}"
export PATH="$GOPATH/bin:$PATH"

command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1 && alias fd='fdfind'

alias lg='lazygit'
alias vim='nvim'

# This file is intentionally not tracked: use it for tokens, host paths, aliases and local tools.
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

[[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
