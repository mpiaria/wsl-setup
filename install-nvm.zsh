#!/bin/zsh

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash;
source ~/.zshrc;
nvm install --lts;
nvm use --lts;
npm install -g npm@latest;
