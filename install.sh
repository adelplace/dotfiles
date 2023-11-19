#!/bin/sh

mkdir ~/.local
mkdir ~/.config
rm ~/.zshrc
rm ~/.zprofile
rm -rf ~/.config/i3
rm -rf ~/.config/alacritty
rm -rf ~/.config/polybar
ln -s ~/dotfiles/.local/bin ~/.local/bin
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zprofile ~/.zprofile
ln -s ~/dotfiles/.config/alacritty ~/.config/alacritty
ln -s ~/dotfiles/.config/polybar ~/.config/polybar
ln -s ~/dotfiles/.config/i3 ~/.config/i3

