#!/bin/bash

set -e

GREEN = '\033[0;32m'
NC = '\033[0m'
if command -v rbenv >/dev/null 2>&1; then
  if ! command -v ruby >/dev/null 2>&1; then
    ruby desktop.rb
  fi
else
  echo -e "${GREEN}Updating repository${NC}"
  sudo pacman -Sy

  echo -e "${GREEN}Installing dependencies for ruby${NC}"
  sudo pacman -S --noconfirm git base-devel openssl zlib libffi

  echo -e "${GREEN}Installing rbenv${NC}"
  sudo pacman -S --noconfirm rbenv ruby-build

  echo -e "${GREEN}Adding to PATH${NC}"
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >>~/.bashrc
  echo 'eval "$(rbenv init -)"' >>~/.bashrc
  source ~/.bashrc

  rbenv install 3.4.2 && rbenv global 3.4.2
  echo -e "Ruby installed, please run the script again"
fi
