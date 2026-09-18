# Рабочее окружение WSL

Гайд для нового Windows-ноутбука с Ubuntu 24.04 в WSL2. Репозиторий содержит только переносимые конфиги: никаких ключей, токенов, shell history, `~/.ssh` и Docker credentials.

## 1. Windows и WSL

Открой PowerShell **от имени администратора**:

```powershell
wsl --install -d Ubuntu-24.04
wsl --update
```

Перезагрузи Windows, запусти Ubuntu и создай Linux-пользователя. Рабочие репозитории держи в `~/projects`, а не в `/mnt/c`: Git, Docker и file watcher'ы там работают ощутимо быстрее.

Поставь Windows Terminal и VS Code. В VS Code добавь расширение **WSL**; затем в папке Linux-проекта работает `code .`. В профиле Ubuntu в Windows Terminal выбери Nerd Font: **MesloLGS NF** или **JetBrainsMono Nerd Font**. Без него иконки Powerlevel10k, LazyVim и LazyGit будут квадратами.

## 2. Установка окружения

В Ubuntu выполни:

```bash
git clone https://github.com/Vladisdev/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh scripts/bootstrap-ubuntu.sh
./scripts/bootstrap-ubuntu.sh
./install.sh
chsh -s "$(command -v zsh)"
exec zsh -l
```

`bootstrap-ubuntu.sh` ставит пакеты Ubuntu, Oh My Zsh, Powerlevel10k и его плагины, актуальные Go, Neovim и LazyGit. Свежие Go/Neovim/LazyGit устанавливаются в `~/.local`, поэтому не требуют глобальных каталогов и не конфликтуют с системными пакетами.

`install.sh` бережно переносит прежние `.zshrc`, `.p10k.zsh`, `.gitconfig`, `~/.config/lazygit` и `~/.config/nvim` в `~/.dotfiles-backup/<дата-время>/`, после чего создаёт симлинки через GNU Stow. Машинные значения — токены, локальные aliases и личные пути — держи в `~/.zshrc.local`; этот файл не отслеживается Git.

После первого запуска `nvim` сам загрузит Lazy.nvim и плагины по `lazy-lock.json`. Затем выполни `:checkhealth`; LSP и форматтеры при необходимости ставятся из `:Mason`.

Проверка:

```bash
zsh --version
nvim --version
lazygit --version
go version
docker version
```

## 3. Docker в WSL — рекомендуемый способ

Для Windows-ноутбука ставь **Docker Desktop**, не Docker Engine в Ubuntu. Docker Desktop управляет демоном в Windows, а WSL использует его через интеграцию.

В PowerShell:

```powershell
winget install -e --id Docker.DockerDesktop
```

Запусти Docker Desktop. В *Settings → General* включи **Use the WSL 2 based engine**, в *Resources → WSL Integration* включи свою Ubuntu. Затем:

```powershell
wsl --shutdown
```

Открой Ubuntu и проверь:

```bash
docker run --rm hello-world
docker compose version
```

Не устанавливай параллельно `docker-ce` или `docker.io` в Ubuntu: получатся конфликтующие Docker daemon'ы и сокеты.

### Отдельный Docker Engine

Если Docker Desktop не подходит, включи systemd. В Ubuntu создай `/etc/wsl.conf`:

```ini
[boot]
systemd=true
```

В PowerShell выполни `wsl --shutdown`, снова войди в Ubuntu и установи Docker Engine по официальной инструкции. После установки:

```bash
sudo usermod -aG docker "$USER"
exit
```

Группа `docker` практически равна root-доступу, поэтому добавляй только свой локальный аккаунт.

## 4. Набор инструментов

Bootstrap уже содержит Git, curl/wget, build-essential, ripgrep, fd, fzf, jq, tmux, zoxide, direnv, архиваторы и доступ к буферу обмена WSL. Он покрывает LazyVim, LazyGit и Go.

Ставь проектные зависимости в самом проекте: `go install` для Go CLI и `docker compose up` для контейнерных сервисов.

Дополнительно по необходимости:

```bash
# Identity намеренно не коммитится
git config --global user.name 'Vladislav'
git config --global user.email 'your-email@example.com'

# GitHub CLI: авторизация, private clone/push, PR
sudo apt install gh
gh auth login

# Отладчик Go для nvim-dap-go
go install github.com/go-delve/delve/cmd/dlv@latest

# PHP-проекты вне Docker
sudo apt install php-cli composer
```

Для Go полезны `go mod tidy`, `go test ./...` и `go vet ./...`. Глобальные npm-пакеты лучше не ставить без необходимости.

## 5. Обновления и восстановление

```bash
cd ~/dotfiles
git pull --ff-only
./install.sh

# Neovim
nvim '+Lazy update' '+MasonUpdate' '+qa'

```

Плагины LazyVim фиксируются в `lazy-lock.json`: после осознанного `:Lazy update` коммить изменённый lock-файл. Обновление Go, Neovim и LazyGit можно выполнить, удалив их пользовательский бинарник/каталог и повторив соответствующий блок bootstrap-скрипта; конфиги от этого не теряются.

Официальные ссылки: [WSL](https://learn.microsoft.com/windows/wsl/install), [Docker Desktop + WSL](https://docs.docker.com/desktop/features/wsl/), [Docker Engine для Ubuntu](https://docs.docker.com/engine/install/ubuntu/), [Go](https://go.dev/doc/install), [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim), [LazyVim](https://www.lazyvim.org/installation), [LazyGit](https://github.com/jesseduffield/lazygit#installation).
