#!/bin/zsh

sudo apt remove docker docker.io containerd runc;

sudo apt update;

sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release;

sudo mkdir -p /etc/apt/keyrings;

if [ ! -f /etc/apt/keyrings/docker.gpg ]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg;
fi

echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;

sudo apt update;

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin;

sudo update-alternatives --set iptables /usr/sbin/iptables-legacy;
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy;

if ! grep -q "docker" /etc/group; then
    sudo groupadd docker;
else
    echo "docker group already exists";
fi

sudo usermod -aG docker $USER;
newgrp docker;

if [ ! -f /etc/wsl.conf ] || ! command sudo grep -qc "service docker start" "/etc/wsl.conf"; then
    echo "" | sudo tee -a /etc/wsl.conf;
    echo "[boot]" | sudo tee -a /etc/wsl.conf;
    echo "command = service docker start" | sudo tee -a /etc/wsl.conf;
else
    echo "Docker service is already in wsl.conf";
fi

sudo service docker start;
sudo apt install -y docker-compose;
