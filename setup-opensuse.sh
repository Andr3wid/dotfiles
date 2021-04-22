#!/bin/bash

#########################################################
# Author: 
# Created:
# Last modified:
# Purpose:
#########################################################

#-------------- VARIABLES 
HOSTNAME=ricebowl
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
read -p "Enter openSUSE Leap version: " -r VERSION


#-------------- CHECK PERMISSION
if [ "$EUID" -ne 0 ]
        then echo "Please run this script with root permission."
        exit
fi

#-------------- SOFTWARE INSTALLATION
read -p "Permission check success; press ENTER to start setup"

echo "--> Installing software from official repositories"
# zypper install -y blender gimp cargo gcc neovim vlc thunar thunar-plugin-archive thunar-plugin-media-tags thunar-volman texlive-latex papirus-icon-theme breeze5-cursors opi steam mpd fzf
zypper install -y cargo

echo "--> Installing rust-tools with cargo"
cargo install alacritty exa bottom zoxide


echo "--> Adding & installing Google Chrome"
zypper addrepo --refresh http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome
wget https://dl.google.com/linux/linux_signing_key.pub
sudo rpm --import linux_signing_key.pub
zypper install -y google-chrome-stable

echo "--> Adding & installing Visual Studio Code"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper addrepo --refresh https://packages.microsoft.com/yumrepos/vscode vscode
sudo zypper install -y code
read -p "-> : Install the following plugins before continuing: Bracket Pair Colorizer, LaTeX Workshop, Markdown PDF, Material Icon Theme, OneDark Pro, Prettier - Code formatter, Todo Tree, TSLint, Vim"

echo "--> Installing & activating snapd for software that is problematic otherwise ...."
zypper addrepo --refresh https://download.opensuse.org/repositories/system:/snappy/openSUSE_Leap_$(echo $VERSION) snappy
zypper --gpg-auto-import-keys refresh
zypper dup --from snappy
zypper install -y snapd
source /etc/profile
systemctl enable snapd --now

echo "--> Installing snap packages"
snap install mailspring discord signal-desktop minecraft-launcher-ot 

echo "--> Installing non-factory software from OBS via opi"
opi zotero
opi arc-theme

echo "--> Download and install jetbrains-toolbox for intellij and android-studio:"
read -p "https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux"


#-------------- VISUAL SETTINGS
read -p  "-> : Set icon / gtk theme in gnome-tweak-tool"
read -p "-> : Install night-theme-switcher gnome shell plugin"
#TODO: install firacode / nerd font

#-------------- CONFIGS
# enable mpd 
# enable and enroll fprintd
# link all dotfiles ...
