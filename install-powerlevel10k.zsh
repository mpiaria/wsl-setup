#!/bin/zsh

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k;

if ! command grep -qc "source ~/powerlevel10k/powerlevel10k.zsh-theme" "$HOME/.zshrc"; then
    echo "" >> ~/.zshrc;
    echo "# powerlevel10k theme" >> ~/.zshrc;
    echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc;
else
    echo "=> powerlevel10k.zsh-theme is already in ~/.zshrc"
fi

source ~/.zshrc;
