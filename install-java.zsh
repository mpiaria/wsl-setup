#!/bin/zsh

sudo apt install -y \
    unzip \
    zip;

curl -s "https://get.sdkman.io" | bash;
source "$HOME/.sdkman/bin/sdkman-init.sh";

sdk install java;
sdk install gradle;
sdk install maven;
