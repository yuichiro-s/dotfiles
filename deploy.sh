#!/usr/bin/env zsh

DF_PATH=$HOME/dotfiles

# copy templates for local setting files to home directory
cp -i $DF_PATH/local/.* ~

# enhancd
git clone --depth 1 https://github.com/b4b4r07/enhancd.git ~/.enhancd

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
