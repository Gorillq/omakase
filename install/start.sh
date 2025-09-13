#!/bin/bash

#set -e

# colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# commands
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

#dependencies
if ! command_exists rbenv; then
  echo -e "${GREEN}Updating repository${NC}"
  sudo pacman -Sy

  echo -e "${GREEN}Installing dependencies for ruby${NC}"
  sudo pacman -S --noconfirm --needed git base-devel openssl zlib libffi libyaml

  echo -e "${GREEN}Installing rbenv${NC}"
  sudo pacman -S --noconfirm rbenv ruby-build

  echo -e "${GREEN}Adding to PATH${NC}"
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >>~/.bashrc
  echo 'eval "$(rbenv init -)"' >>~/.bashrc
  
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  rbenv install 3.4.2
  if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to install ruby. Exiting.${NC}"
    exit 1
  fi
  rbenv global 3.4.2
  rbenv rehash
  source ~/.bashrc
else
  echo -e "${GREEN}rbenv installed, skipping${NC}"
fi

if command_exists ruby; then
  echo -e "${GREEN}Ruby is installed${NC}"
  
yay_file="$(dirname "$0")/lib/yay.rb"
  if [ -f "$yay_file" ]; then
    echo -e "${GREEN}Running yay.rb first${NC}"
    ruby "$yay_file"
    if [ $? -ne 0 ]; then
      echo -e "${RED}yay.rb failed. Installation cannot continue..${NC}"
      sleep 10s
      exit 1
    fi
  else
    echo -e "${RED}yay.rb not found in ../lib/. Exiting.${NC}"
    sleep 10s
    exit 1
  fi

  for file in $(dirname "$0")/lib/*.rb; do
    if [ -f "$file" ] && [ "$file" != "$yay_file" ]; then
      echo -e "${GREEN}Running file $file${NC}"
      ruby "$file"
      if [ $? -ne 0 ]; then
        echo -e "${RED}$file failed with exit code $?. Continuing to next file...${NC}"
      fi
    fi
  done
  echo -e "${GREEN}All files executed. Have fun!${NC}"
  echo -e "${RED}Reboot in 1 minute! Ctrl+c to cancel${NC}"
  sleep 60s
  sudo reboot
else
  echo -e "${RED}Ruby is not available. Something went wrong with rbenv setup.${NC}"
  echo "Try running 'source ~/.bashrc' or restarting your terminal, then run this script again."
  exit 1
fi

