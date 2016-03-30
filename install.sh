#!/bin/sh

# Created by Pascal "Arial7" Riesinger
# Licensed under MIT license. Feel free to copy these files and base your own
# dotfiles on mine.

# This script will install all of the dotfiles, as well as provide a simple
# 'bootstrap' function wich will install my most commonly used programs and
# tools. Note that this is intended for Archlinux, so bootstraping does not 
# work on other distros.

if [ "$1" == "bootstrap" ]; then
# BOOTSTRAP
    echo "Starting bootstrap..."
    echo "Checking for yaourt"
    which yaourt > /dev/null
    
    if [ $? != "0" ]; then

        echo "Downloading pq and yaourt"
        
        which wget > /dev/null
        if [ $? != "0" ]; then
            sudo pacman -S wget
        fi

        wget "https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz"
        wget "https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz"

        tar xvzf yaourt.tar.gz
        tar xvzf package-query.tar.gz
        
        cd package-query
        makepkg -si
        cd ../yaourt
        makepkg -si
        cd ..

        echo "Cleaning up"
        rm -rf package-query yaourt 
   
    fi
    
    echo "Installing common packages"
    sudo yaourt -Syu --needed --noconfirm git neovim htop zsh lm_sensors \
        ttf-hack thefuck termite nodejs npm
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo "Installing common npm modules"
    sudo npm install -g grunt-cli coffee-script jade instant-markdown-d


    echo "Finished bootstrap"

else
# INSTALL DOTFILES
    echo "Installing dotfiles"


    DOTFILES=$HOME/.dotfiles

    echo -e "\nCreating symlinks"
    echo "=============================="
    linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
    for file in $linkables ; do
        target="$HOME/.$( basename $file ".symlink" )"
        if [ -e $target ]; then
            echo "~${target#$HOME} already exists... Skipping."
        else
            echo "Creating symlink for $file"
            ln -s $file $target
        fi
    done

    echo -e "\n\ninstalling to ~/.config"
    echo "=============================="
    if [ ! -d $HOME/.config ]; then
        echo "Creating ~/.config"
        mkdir -p $HOME/.config
    fi
    for config in $DOTFILES/config/*; do
        target=$HOME/.config/$( basename $config )
        if [ -e $target ]; then
            echo "~${target#$HOME} already exists... Skipping."
        else
            echo "Creating symlink for $config"
            ln -s $config $target
        fi
    done         

fi
