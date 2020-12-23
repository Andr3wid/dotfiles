#!/bin/bash

##########################################################
## Author: 		Andreas Kogler			##
## Created: 		22nd December 2020		##
## Last modfied:	LAST_GIT_COMMIT DATE (TODO!)	##
## Purpose: 		Fedora Linux setup automation	##
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


echo "--> Checking for system updates"
echo "TODO: not update, but check for updates"


echo "--> Updating firmware"
fwupdmgr update


echo "--> Enabling supplementary repositories"
echo "- RPMFusion"
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
echo "- Brave browser"
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
echo "- Visual Studio Code"
rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'


echo "--> Installing software from repositories"
dnf install neovim exa dnf-plugins-core brave evolution evolution-ews code texlive-scheme-full java-latest-openjdk-devel blender feh gimp youtube-dl anki ffmpeg flameshot vlc ffmpeg-libs compat-ffmpeg28 gstreamer1-libav gstreamer-plugins-ugly unrar git steam mpd ncmpcpp mpc tlp tlp-rdw cmake make gcc g++ docker i3lock rofi nmap dreamchess alacritty starship polybar light cryptopp libzen libmediainfo zathura mupdf zathura-mpdf-mupdf golang golint winetricks audacity openshot compton dunst fontawesome-fonts

echo "--> Installing software from external sources"
# TODO: install i3-gaps, rpiplay (airplay-server), minecraft-launcher, google chrome, intellij, megasync client, nerd fonts, discord
dnf copr enable atim/bottom -y
dnf install bottom


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
echo "- copying system config files"
if [ -f $TOUCHPAD_CONF ]
	then mv $TOUCHPAD_CONF $TOCHPAD_CONF.bak
fi
cp -f 90-touchpad.conf $TOUCHPAD_CONF
# TODO: alter pam login conf to unlock keyring in i3
# TODO: check if polybar fonts are covered by nerd fonts
echo "- permission fix for .ssh config file"
chmod 600 /home/$USERNAME/.ssh/config
chown $USERNAME /home/$USERNAME/.ssh/config


echo "--> Setting up root account and sudo permissions"
echo "- redirecting bashrc"
mv /root/.bashrc /root/.bashrc.bak && ln -s /home/$USERNAME/.bashrc /root/bashrc
echo "- disabling sudo pw prompt"
# TODO: Check how to correctly edit sudoers file with script (visudo?)


echo "--> Enrolling fingerprint"
fprintd-enroll


echo "--> Starting installed services"
systemctl start tlp
systemctl --user start mpd
