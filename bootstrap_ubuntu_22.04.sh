
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

# Essential packages using apt
# Enable netspeed using gnome-shell-extension-manager
echo -e '\033[0;32m===== Installing essential packages using apt =====\033[0m'
sudo apt-fast -y install vim ntp tree net-tools gnome-shell-extension-manager git pdfarranger

# Essential packages using snap
echo -e '\033[0;32m===== Installing essential packages using snap =====\033[0m'
sudo snap install git-standup ffmpeg nmap firefox libreoffice ngrok net-toolbox vlc youtube-dl sublime-text jq

# zsh
echo -e '\033[0;32m===== Installing zsh =====\033[0m'
sudo apt-fast -y install zsh
sudo sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
wget -c https://raw.githubusercontent.com/rupa/z/master/z.sh
chmod +x z.sh
sudo mv z.sh /usr/local/bin

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
echo "deb http://packages.azlux.fr/debian/ buster main" | sudo tee /etc/apt/sources.list.d/azlux.list
wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -
sudo apt-fast -y install broot

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
# sudo update-alternatives --config java

# IntelliJ IDEA
sudo snap install intellij-idea-ultimate --classic
