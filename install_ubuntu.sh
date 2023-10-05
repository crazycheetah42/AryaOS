#!/bin/bash

sudo apt update
whiptail --msgbox "Welcome to the AryaOS installer.\n\nThis installer will install the configurations I use for my Linux desktop. It uses BSPWM." 10 50
maindir=$(pwd)
whiptail --yesno "Do you want to proceed with the installation?" 10 50

if [ $? -eq 0 ]; then
    builddir=$(pwd)
    username=$(id -u -n 1000)
    # Create directories
    echo "Creating user & config directories..."
    mkdir -p $HOME/.config
    mkdir -p $HOME/.fonts
    mkdir -p $HOME/Documents
    mkdir -p $HOME/Downloads
    mkdir -p $HOME/Pictures
    mkdir -p $HOME/Videos
    mkdir -p $HOME/Music
    cp .Xresources $HOME/
    cp .Xnord $HOME/

    echo "Copying config..."
    cp -r dotconfig/* $HOME/.config/
    cp background.jpg $HOME/Pictures/
    mv user-dirs.dirs $HOME/.config/
    sudo chown -R $username:$username /home/$username

    echo "Installing essential programs..."
    sudo apt install cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python3-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev libjsoncpp-dev feh bspwm sxhkd kitty rofi python3-pip thunar lxpolkit x11-xserver-utils unzip yad wget pulseaudio pavucontrol -y
    echo "Installing optional programs..."
    sudo apt install neofetch lxappearance papirus-icon-theme fonts-noto-color-emoji lightdm fonts-font-awesome -y


    echo "Installing theme (Sweet-Dark-v40)"
    wget https://github.com/EliverLara/Sweet/releases/download/v3.0/Sweet-Dark-v40.zip
    unzip Sweet-dark-v40.zip
    sudo mv Sweet-dark-v40 /usr/share/themes/
    sudo rm -r Sweet-Dark-v40.zip

    echo "Installing fonts..."
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
    unzip FiraCode.zip -d /home/$username/.fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
    unzip Meslo.zip -d /home/$username/.fonts
    mv dotfonts/fontawesome/otfs/*.otf /home/$username/.fonts/
    chown $username:$username /home/$username/.fonts/*

    fc-cache -vf
    rm ./FiraCode.zip ./Meslo.zip

    echo "Installing cursor theme (Breeze)..."
    sudo apt install breeze-cursor-theme -y

    echo "Installing browser (Brave Browser)..."
    sudo apt install apt-transport-https curl -y
    curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser -y

    echo "Enabling display manager (sddm)..."
    sudo systemctl enable sddm
    sudo systemctl set-default graphical.target

    echo "Installing ainstall package manager..."
    sudo mv ainstall /usr/bin/ainstall
    sudo chmod +x /usr/bin/ainstall
    sudo mkdir -p /packagerepos/aryaos
    sudo mkdir -p /packages/aryaos
    export PATH=$PATH:/packages/aryaos

    echo "Adding AryaOS custom .bashrc file..."
    sudo rm -r $HOME/.bashrc
    sudo cp -r $builddir/.bashrc

    echo "Installing polybar..."
    sudo ln -s /usr/include/jsoncpp/json/ /usr/include/json
    git clone https://github.com/jaagr/polybar.git
    cd polybar
    echo "Please say yes to everything EXCEPT anything related to I3-WM!
    sudo ./build.sh

    echo "Installing Polybar themes..."
    chmod +x ./polybar-themes/setup.sh
    echo "Please press 1 when prompted for a number."
    ./polybar-themes/setup.sh
    chmod +x $HOME/.config/polybar/launch.sh

    cd $maindir
    sudo rm -r ~/.config/bspwm/bspwmrc
    sudo cp dotconfig/bspwm/bspwmrc ~/.config/bspwm/
    whiptail --msgbox "Installation completed successfully!" 8 50
else
    whiptail --msgbox "Installation canceled." 8 50
fi
