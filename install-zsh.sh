#!/bin/bash

# Install zsh
sudo apt install -y zsh;

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";

# Change default shell to zsh
zsh;
chsh -s $(which zsh);
