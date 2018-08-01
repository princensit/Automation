#!/bin/bash
##########################################################################
# This script is to bootstrap Ubuntu 18.04 LTS with required packages
#
# @author      Prince Raj
# @version     1.0
# @since       2018-08-01
##########################################################################

PACKAGES="$HOME/Downloads/Softwares"

echo -e '\033[0;32m=====Resynchronize the package index files=====\033[0m'
sudo apt-get -y install -f
sudo apt-get update
sudo apt-get -y upgrade

# Displaying Hidden Startup Applications:
echo -e '\033[0;32m=====Displaying hidden startup applications=====\033[0m'
sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/*.desktop

# Remove unnecessary folders
echo -e '\033[0;32m=====Remove unnecessary folders=====\033[0m'
rm -rf ~/Documents ~/Public

# apt-fast
echo -e '\033[0;32m=====Installing apt-fast=====\033[0m'
sudo add-apt-repository -y ppa:apt-fast/stable
sudo apt-get update
sudo apt-get -y install apt-fast

# Google Chrome
echo -e '\033[0;32m=====Installing Google Chrome browser=====\033[0m'
sudo dpkg -i "${PACKAGES}/Google Chrome/google-chrome-stable_current_amd64.deb"
sudo apt-fast install -f

# Sublime Text Editor 3
echo -e '\033[0;32m=====Installing Sublime Text Editor=====\033[0m'
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-fast update
sudo apt-fast -y install sublime-text
cp "${PACKAGES}/Sublime Text 3/Default (Linux).sublime-keymap" ~/.config/sublime-text-3/Packages/User/
cp "${PACKAGES}/Sublime Text 3/Preferences.sublime-settings" ~/.config/sublime-text-3/Packages/User/
sudo sed -i 's/gedit.desktop/sublime-text.desktop/g' /etc/gnome/defaults.list
sudo sed -i 's/gedit.desktop/sublime-text.desktop/g' /usr/share/applications/defaults.list

# VIM
echo -e '\033[0;32m=====Installing vim=====\033[0m'
sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt-fast update
sudo apt-fast -y install vim

# Essential packages
echo -e '\033[0;32m=====Installing essential packages=====\033[0m'
sudo apt-fast -y install ntp curl sysstat htop tree nload wavemon iptraf nethogs nmon screen unetbootin mutt meld artha subversion ubuntu-restricted-extras wine64 gimp gparted libav-tools python-pip gnome-tweaks nmap

# Upgrade nautilus
echo -e '\033[0;32m=====Upgrading nautilus=====\033[0m'
sudo add-apt-repository -y ppa:gnome3-team/gnome3
sudo apt-fast update
sudo apt-fast -y upgrade
killall nautilus

# ecm -> iso
sudo apt-fast -y install ecm
sudo apt-fast -y install acetoneiso

# Monitor Linux Server Performance in Real-Time
echo -e '\033[0;32m=====Installing dstat=====\033[0m'
sudo apt-fast -y install dstat

# Terminator
echo -e '\033[0;32m=====Installing terminator=====\033[0m'
sudo apt-fast -y install terminator
mkdir -p ~/.config/terminator/
# cp "${PACKAGES}/Terminator/config" ~/.config/terminator/

# Netspeed
echo -e '\033[0;32m=====Installing Netspeed indicator=====\033[0m'
sudo apt-add-repository -y ppa:fixnix/netspeed
sudo apt-fast update
sudo apt-fast -y install indicator-netspeed-unity

# Multiload
echo -e '\033[0;32m=====Installing multiload=====\033[0m'
sudo apt-fast -y install indicator-multiload

# Git
echo -e '\033[0;32m=====Installing git=====\033[0m'
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt-fast update
sudo apt-fast -y install git

# Nginx
echo -e '\033[0;32m=====Installing nginx=====\033[0m'
sudo add-apt-repository -y ppa:nginx/stable
sudo apt-fast update
sudo apt-fast -y install nginx

# Apache2
echo -e '\033[0;32m=====Installing apache2=====\033[0m'
sudo apt-fast -y install apache2
sudo sed -i 's/Listen 80/Listen 8085/g' /etc/apache2/ports.conf
sudo a2enmod cgi
sudo service apache2 restart

#  AWS cli
sudo apt-fast -y install awscli
sudo pip install --upgrade awscli

# Youtube-dl
echo -e '\033[0;32m=====Installing youtube-dl=====\033[0m'
sudo add-apt-repository -y ppa:nilarimogard/webupd8
sudo apt-fast update
sudo apt-fast -y install youtube-dl
sudo pip install --upgrade youtube-dl

# Master PDF Editor
echo -e '\033[0;32m=====Installing Master PDF Editor=====\033[0m'
sudo dpkg -i "${PACKAGES}/Master PDF Editor/master-pdf-editor-4.2.68_qt5.amd64.deb"
sudo sed -i 's/evince.desktop/masterpdfeditor4.desktop/g' /etc/gnome/defaults.list
sudo sed -i 's/evince.desktop/masterpdfeditor4.desktop/g' /usr/share/applications/defaults.list

# JDK
echo -e '\033[0;32m=====Installing JDK=====\033[0m'
sudo rm -rf /usr/lib/jvm/default-java
sudo rm -rf /usr/lib/jvm/jdk1.7.0_80
sudo rm -rf /usr/lib/jvm/jdk1.8.0_181
sudo mkdir -p /usr/lib/jvm
tar -xvzf "${PACKAGES}/JDK/jdk-7u80-linux-x64.tar.gz"
sudo mv jdk1.7.0_80 /usr/lib/jvm
sudo ln -s /usr/lib/jvm/jdk1.7.0_80 /usr/lib/jvm/default-java
tar -xvzf "${PACKAGES}/JDK/jdk-8u181-linux-x64.tar.gz"
sudo mv jdk1.8.0_181 /usr/lib/jvm
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/default-java/bin/javac 1
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/default-java/bin/java 1
sudo cp "${PACKAGES}/JDK/visualvm.desktop" /usr/share/applications/visualvm.desktop

# Apache Maven
echo -e '\033[0;32m=====Installing Apache Maven=====\033[0m'
sudo rm -rf /usr/local/apache-maven-3.5.0
tar -xvzf "${PACKAGES}/Apache Maven/apache-maven-3.5.4-bin.tar.gz"
sudo mv apache-maven-3.5.4 /usr/local
sudo ln -s /usr/local/apache-maven-3.5.4 /usr/local/default-mvn

# Apache Tomcat
echo -e '\033[0;32m=====Installing Apache Tomcat=====\033[0m'
sudo rm -rf /usr/local/apache-tomcat-7.0.90
sudo rm -rf /usr/local/apache-tomcat-8.5.32
tar -xvzf "${PACKAGES}/Apache Tomcat/apache-tomcat-7.0.90.tar.gz"
sudo mv apache-tomcat-7.0.90 /usr/local
tar -xvzf "${PACKAGES}/Apache Tomcat/apache-tomcat-8.5.32.tar.gz"
sudo mv apache-tomcat-8.5.32 /usr/local

# IntelliJ IDEA
echo -e '\033[0;32m=====Installing IntelliJ IDEA=====\033[0m'
tar -xvzf "${PACKAGES}/IntelliJ Idea/ideaIU-2018.2.tar.gz"
sudo mv idea-IU-182.3684.101 /usr/local

# Skype
echo -e '\033[0;32m=====Installing Skype=====\033[0m'
curl -s https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add -
sudo dpkg -i "${PACKAGES}/Skype/skypeforlinux-64.deb"

# Windows USB Installer
echo -e '\033[0;32m=====Installing Windows USB Installer=====\033[0m'
sudo apt-fast -y install woeusb

# JSON processor
echo -e '\033[0;32m=====Installing JSON processor=====\033[0m'
sudo apt-fast -y install jq

# Node.js
echo -e '\033[0;32m=====Installing Node.js=====\033[0m'
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-fast -y install nodejs
sudo npm install http-server -g

# Opera Developer
echo -e '\033[0;32m=====Installing Opera Developer=====\033[0m'
wget -q -O- http://deb.opera.com/archive.key | sudo apt-key add -
sudo sh -c 'echo "deb http://deb.opera.com/opera-stable/ stable non-free" > /etc/apt/sources.list.d/opera.list'
sudo apt-fast update
sudo apt-fast -y install opera-developer

# OpenVPN
echo -e '\033[0;32m=====Installing OpenVPN=====\033[0m'
sudo apt-fast -y install openconnect openvpn network-manager-openvpn-gnome

# pip
echo -e '\033[0;32m=====Installing pip=====\033[0m'
sudo pip install --upgrade pip
sudo pip install --upgrade speedtest-cli

# Simple screen recorder
echo -e '\033[0;32m=====Installing simple screen recorder=====\033[0m'
sudo add-apt-repository -y ppa:maarten-baert/simplescreenrecorder
sudo apt-fast -y install simplescreenrecorder

# Schedule task
echo -e '\033[0;32m=====Installing at=====\033[0m'
sudo apt-fast -y install at

# VLC player
echo -e '\033[0;32m=====Installing VLC player=====\033[0m'
sudo add-apt-repository -y ppa:videolan/master-daily
sudo apt-fast update
sudo apt-fast -y install vlc browser-plugin-vlc

# WebTorrent
sudo dpkg -i "${PACKAGES}/WebTorrent/webtorrent-desktop_0.20.0-1_amd64.deb"

# Install ADB And Fastboot Android Tools
echo -e '\033[0;32m=====Installing adb=====\033[0m'
sudo apt-fast -y install android-tools-adb android-tools-fastboot

# NFS 2 SE
echo -e '\033[0;32m=====Installing NFS 2 SE=====\033[0m'
wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu xenial-getdeb games" > /etc/apt/sources.list.d/getdeb.list'
sudo apt-fast update
sudo apt-fast -y install nfs2se

# Wireshark
echo -e '\033[0;32m=====Installing Wireshark=====\033[0m'
sudo add-apt-repository -y ppa:wireshark-dev/stable
sudo apt-fast update
sudo apt-fast -y install wireshark

# MySQL server
echo -e '\033[0;32m=====Installing MySQL server=====\033[0m'
sudo apt-fast -y install libmysqlclient-dev mysql-server

# PostgreSQL server
echo -e '\033[0;32m=====Installing PostgreSQL server=====\033[0m'
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget -q -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-fast update
sudo apt-fast -y install libpq-dev postgresql-10 pgadmin4

# Ngrok
# https://ngrok.com/download

# zsh
echo -e '\033[0;32m=====Installing zsh=====\033[0m'
sudo apt-fast -y install zsh
sudo sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
wget -c https://raw.githubusercontent.com/rupa/z/master/z.sh
chmod +x z.sh
sudo mv z.sh /usr/local/bin

# Enable minimise on click for the Ubuntu Dock
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
