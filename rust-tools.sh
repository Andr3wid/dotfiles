#!/bin/bash
echo "--> Installing rust, rust-tools, cargo ..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
export PATH=$PATH:~/.cargo/bin
# TODO: alacritty problem fontconfig
cargo install exa bottom zoxide alacritty
