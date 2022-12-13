
#!/bin/bash
##########################################################################
# This script is to bootstrap Ubuntu 22.04 LTS with required packages
#
# @author      Prince Raj
# @version     1.0
# @since       2022-12-13
##########################################################################

# Upgrade to latest version
echo -e '\033[0;32m===== Resynchronize the package index files =====\033[0m'
sudo apt-get -y install -f
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get dist-upgrade

# Change desktop and login background wallpaper

# Displaying Hidden Startup Applications
echo -e '\033[0;32m===== Displaying hidden startup applications =====\033[0m'
sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/*.desktop

# Remove unnecessary folders
echo -e '\033[0;32m===== Remove unnecessary folders =====\033[0m'
rm -rf ~/Documents ~/Public

# apt-fast
echo -e '\033[0;32m===== Installing apt-fast =====\033[0m'
sudo add-apt-repository -y ppa:apt-fast/stable
sudo apt-get update
sudo apt-get -y install apt-fast

# Google Chrome
echo -e '\033[0;32m===== Installing Google Chrome browser =====\033[0m'
wget -qO - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-fast install -f

# snapd
sudo apt-fast -y install snapd
# sudo snap set system refresh.retain=2
# sudo snap list
# sudo snap list --all
# snap snap remove <package> --purge
# sudo snap refresh --list
# snap changes
# sudo snap set system experimental.refresh-app-awareness=true

# Essential packages using apt
# Enable netspeed using gnome-shell-extension-manager
echo -e '\033[0;32m===== Installing essential packages using apt =====\033[0m'
sudo apt-fast -y install vim ntp tree net-tools gnome-shell-extension-manager git pdfarranger

# Essential packages using snap
echo -e '\033[0;32m===== Installing essential packages using snap =====\033[0m'
sudo snap install git-standup ffmpeg nmap libreoffice ngrok net-toolbox vlc youtube-dl sublime-text jq

# zsh
echo -e '\033[0;32m===== Installing zsh =====\033[0m'
sudo apt-fast -y install zsh
sudo sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
wget -c https://raw.githubusercontent.com/rupa/z/master/z.sh
chmod +x z.sh
sudo mv z.sh /usr/local/bin

# Firefox
sudo snap remove firefox
sudo add-apt-repository -y ppa:mozillateam/ppa
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
sudo apt-fast update
sudo apt-fast -y install firefox

# Terminator
echo -e '\033[0;32m===== Installing terminator =====\033[0m'
sudo apt-fast -y install terminator
mkdir -p ~/.config/terminator/
curl -so ~/.config/terminator/config https://raw.githubusercontent.com/princensit/Automation/master/configurations/terminator/config

# JSON processor
echo -e '\033[0;32m===== Installing JSON processor =====\033[0m'
sudo snap install jq

# Schedule task
echo -e '\033[0;32m===== Installing at (schedule task) =====\033[0m'
sudo apt-fast -y install at

# Android tools
sudo apt-fast -y install android-tools-adb android-tools-fastboot 

# Torrent
sudo apt-fast -y install webtorrent-desktop

# Install Broot (A better way to navigate directories)
echo "deb [signed-by=/usr/share/keyrings/azlux-archive-keyring.gpg] http://packages.azlux.fr/debian/ stable main" | sudo tee /etc/apt/sources.list.d/azlux.list
sudo wget -O /usr/share/keyrings/azlux-archive-keyring.gpg  https://azlux.fr/repo.gpg
sudo apt-fast update
sudo apt-fast -y install broot
# broot

# Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-fast update
sudo apt-fast -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo systemctl status docker
wget https://desktop.docker.com/linux/main/amd64/docker-desktop-4.15.0-amd64.deb
sudo apt install ./docker-desktop-4.15.0-amd64.deb

# MySQL
docker pull mysql:8
sudo apt-fast -y install mysql-client
mkdir -p /home/prince/codebase/docker-config/mysql_config/mysql_v8/conf.d
touch /home/prince/codebase/docker-config/mysql_config/mysql_v8/conf.d/my-custom.cnf
mkdir -p /home/prince/codebase/docker-config/mysql_data
# docker run --detach --name mysql_v8 --publish 3306:3306 --env="MYSQL_ROOT_PASSWORD=root" --volume=/home/prince/codebase/docker-config/mysql_config/mysql_v8/conf.d:/etc/mysql/conf.d --volume=/home/prince/codebase/docker-config/mysql_data:/var/lib/mysql mysql:8
# mysql -h 127.0.0.1 -u root -p

# DynamoDB
docker pull amazon/dynamodb-local
# alias dynamodb_local='docker run -p 8000:8000 amazon/dynamodb-local'

# Dive (A tool for exploring each layer in a docker image)
sudo apt-fast -y install dive

# ctop (Top-like interface for container metrics)
sudo apt-fast -y install ctop

# webhookd (webhook server launching shell scripts)
# https://github.com/ncarlier/webhookd
sudo apt-fast -y install webhookd

# Slack, Zoom
sudo snap install slack zoom-client

# Master PDF Editor
# echo -e '\033[0;32m===== Installing Master PDF Editor =====\033[0m'
# sudo dpkg -i "master-pdf-editor-4.3.89_qt5.amd64.deb"

# AWS CLI
echo -e '\033[0;32m===== AWS CLI =====\033[0m'
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Apache Maven
sudo apt-fast -y install maven

# Gradle
sudo snap install gradle --classic

# JDK
sudo snap install openjdk-8-jdk openjdk-11-jdk openjdk-17-jdk

# IntelliJ IDEA
sudo snap install intellij-idea-ultimate --classic
