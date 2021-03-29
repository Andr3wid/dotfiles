#!/bin/bash

##########################################################
## Author: 		Andreas Kogler			##
## Created: 		22nd December 2020		##
## Last modfied:	LAST_GIT_COMMIT DATE (TODO!)	##
## Purpose: 		Ubuntu Linux setup automation	##
##########################################################

#------------ VARIABLES
HOSTNAME=ricebowl
USERNAME=andrew
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TOUCHPAD_CONF=/etc/xorg.conf.d/X11/90-touchpad.conf

#------------ PERMISSION CHECK
if [ "$EUID" -ne 0 ]
	then echo "Please run this script with root permission."
	exit
fi

#------------ SETUP EXECUTION
read -p "Setup script ready to run, press ENTER to start."

echo "-->  Changing hostname to '$HOSTNAME'"
echo $HOSTNAME > /etc/hostname

echo "--> Enabling brave-browser repo"
apt install -y apt-transport-https curl gnupg # needed for repo import

echo "Adding brave to keyring"
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list

echo "--> Enabling vs code repo"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg

install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/

sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'

# TODO: add node repo for up2date node versions


echo "refreshing repos"
apt update

echo "--> Installing software from repositories"
apt install exa neovim brave-browser code default-jdk texlive-full vlc blender feh gimp youtube-dl anki ffmpeg flameshot unrar steam mpd ncmpcpp mpc tlp tlp-rdw cmake make gcc g++ docker i3lock rofi nmap golang golint brightnessctl libmediainfo0v5 winetricks audacity openshot picom dunst network-manager visualboyadvance desmume i3 thunar polybar thunar-archive-plugin blueman thunar-media-tags-plugin

# TODO: automate
echo "--> install the following vs code plugins manually: go, c++, answer set prog, material icons, dark pro, liveshare, latex, todo tree, vim, tslint, bracket colorizer; press ENTER when you are done"
read -p ":"

echo "--> install the following software manually: google chrome, rpiplay, bottom, i3-gaps, minecraft, intellij idea, insync, nerd fonts, discord, alacritty, starship; press ENTER when you are done"
read -p ":"

echo "--> symlinking binaries & create .desktop entries"
ln -sf $SCRIPT_DIR/bin/visualboyadvance-m /opt/visualboyadvance-m
ln -sf $SCRIPT_DIR/bin/rpiplay /opt/rpiplay
cp shortcuts/visualboyadvance.desktop /usr/share/applications/


echo "--> Setting up dotfiles"
echo "- linking dotfiles to actual directories"
# TODO: actually link all dotfiles ..
ln -sf $SCRIPT_DIR/polybar /home/$USERNAME/.config/polybar
ln -sf $SCRIPT_DIR/mpd /home/$USERNAME/.config/mpd
ln -sf $SCRIPT_DIR/ncmpcpp /home/$USERNAME/.config/ncmpcpp
# TODO: version .ssh/config, but encrypted & decrypt after cloning
ln -sf $SCRIPT_DIR/.Xresources /home/$USERNAME/.Xresources && xrdb /home/$USERNAME/.Xresources
ln -sf $SCRIPT_DIR/starship.toml /home/$USERNAME/.config/starship.toml
ln -sf $SCRIPT_DIR/i3 /home/$USERNAME/.config/i3 && chmod +x launch_polybar.sh
ln -sf $SCRIPT_DIR/.bashrc /home/$USERNAME/.bashrc
ln -sf $SCRIPT_DIR/rofi /home/$USERNAME/.config/rofi
ln -sf $SCRIPT_DIR/alacritty.yml /home/$USERNAME/.config/alacritty.yml
ln -sf $SCRIPT_DIR/.gtkrc-2.0 /home/$USERNAME/.gtkrc-2.0
ln -sf $SCRIPT_DIR/gtk-3.0 /home/$USERNAME/.config/gtk-3.0
ln -sf $SCRIPT_DIR/picom /home/$USERNAME/.config/picom
ln -sf $SCRIPT_DIR/nvim /home/$USERNAME/.config/nvim

echo "- copying system config files"
if [ -f $TOUCHPAD_CONF ]
	then mv $TOUCHPAD_CONF $TOCHPAD_CONF.bak
fi
cp -f 90-touchpad.conf $TOUCHPAD_CONF
# TODO: alter pam login conf to unlock keyring in i3
# TODO: check if polybar fonts are covered by nerd fonts
# TODO: install fontawesome 4.71 
echo "- install nord gtk & icon themes"
# TODO: git clone git@github.com:robertovernina/NordArc.git
# TODO: copy to local/share/themes and .local/share/icons
# TODO: set using gsettings? or something ..
echo "- permission fix for .ssh config file"
chmod 600 /home/$USERNAME/.ssh/config
chown $USERNAME /home/$USERNAME/.ssh/config


echo "--> Setting up root account and sudo permissions"
echo "- redirecting bashrc"
mv /root/.bashrc /root/.bashrc.bak && ln -s /home/$USERNAME/.bashrc /root/bashrc
echo "- disabling sudo pw prompt"
echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

echo "--> Enrolling fingerprint"
fprintd-enroll

echo "--> Adding user to groups for brightnessctl"
usermod -a -G video $USERNAME
usermod -a -G input $USERNAME

echo "--> Starting installed services"
systemctl start tlp
systemctl --user enable tlp
systemctl --user start mpd
systemctl --user enable mpd

