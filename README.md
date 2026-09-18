# Vladisdev dotfiles

Переносимая конфигурация WSL/Ubuntu для zsh, Powerlevel10k, LazyVim и LazyGit.

Полный стартовый гайд — в [docs/WORKSTATION.md](docs/WORKSTATION.md): WSL2, Docker, Go, Neovim, LazyGit и первый запуск.

## Состав

- `zsh/` — `.zshrc` и текущая тема Powerlevel10k;
- `nvim/` — LazyVim с настройками Go/frontend и зафиксированным `lazy-lock.json`;
- `lazygit/` — базовая настройка LazyGit для Nerd Font 3;
- `git/` — общие настройки Git без личных имени и e-mail;
- `scripts/bootstrap-ubuntu.sh` — установка зависимостей на чистой Ubuntu;
- `install.sh` — резервная копия старых файлов и deployment через GNU Stow.

Не добавляй сюда `~/.ssh`, историю shell, `.env`, Docker credentials и токены. Для отличий конкретной машины используй `~/.zshrc.local`.
