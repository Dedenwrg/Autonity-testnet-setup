#!/bin/bash

# Function to check if a package is installed
package_installed() {
    dpkg -s "$1" 2>/dev/null | grep -q "Status: install ok installed"
}

# Prerequisites
sudo apt update && sudo apt upgrade -y
sudo apt install python3 git curl -y
sudo apt-get install python3-pip
python3 -m pip install --user pipx
python3 -m pipx ensurepath

# Install httpie
curl -SsL https://packages.httpie.io/deb/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/httpie.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/httpie.gpg] https://packages.httpie.io/deb ./" | sudo tee /etc/apt/sources.list.d/httpie.list
sudo apt update
sudo apt install httpie -y

# Check if pipx is installed
if ! package_installed pipx; then
    # Install pipx if not installed
    python3 -m pip install --user pipx
    python3 -m pipx ensurepath
    apt install python3.8-venv
fi

# Restart terminal
echo "Please close and reopen your terminal to apply changes."

# Install Docker
curl -sO https://raw.githubusercontent.com/Dedenwrg/Autonity-testnet-setup/main/docker.sh
chmod +x docker.sh
bash docker.sh

# Check if UFW is installed
if ! package_installed ufw; then
    # Install UFW if not installed
    sudo apt install ufw -y
fi

# Configure UFW
sudo ufw allow 30303/tcp
sudo ufw allow 30303/udp
sudo ufw allow 8545/tcp
sudo ufw allow 8546/tcp
sudo ufw allow 6060/tcp
sudo ufw allow ssh
sudo ufw enable

# Set External IP as an environment variable
EXTERNAL_IP=$(curl -s ifconfig.me)
echo "export EXTERNAL_IP=${EXTERNAL_IP}" >> ~/.bashrc

# Inform user about completion and ask for exit
echo "Installation completed. Do you want to exit? (y/n)"
read -r choice

if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
    exit
fi

echo "You can now use your system with the installed configurations."
