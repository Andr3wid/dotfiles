#!/bin/bash
SCRIPT_DIR=/home/andrew/git/personal/dotfiles
USERNAME=andrew
echo "--> Setting up dotfiles"
echo "- linking dotfiles to actual directories"
# TODO: actually link all dotfiles ..
ln -sf $SCRIPT_DIR/mpd /home/$USERNAME/.config/mpd
ln -sf $SCRIPT_DIR/ncmpcpp /home/$USERNAME/.config/ncmpcpp
# TODO: version .ssh/config, but encrypted & decrypt after cloning
ln -sf $SCRIPT_DIR/.Xresources /home/$USERNAME/.Xresources && xrdb /home/$USERNAME/.Xresources
ln -sf $SCRIPT_DIR/starship.toml /home/$USERNAME/.config/starship.toml
ln -sf $SCRIPT_DIR/.bashrc /home/$USERNAME/.bashrc
ln -sf $SCRIPT_DIR/alacritty.yml /home/$USERNAME/.config/alacritty.yml
ln -sf $SCRIPT_DIR/nvim /home/$USERNAME/.config/nvim


