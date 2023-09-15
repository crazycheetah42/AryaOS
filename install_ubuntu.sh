#!/bin/bash

sudo apt update
whiptail --msgbox "Welcome to the AryaOS installer.\n\nThis installer will install the configurations I use for my Linux desktop. It uses BSPWM." 10 50
$maindir = $(pwd)
whiptail --yesno "Do you want to proceed with the installation?" 10 50

if [ $? -eq 0 ]; then
    chmod +x base_install.sh
    sudo ./base_install.sh
    cd $maindir
    sudo rm -r ~/.config/bspwm/bspwmrc
    sudo cp dotconfig/bspwm/bspwmrc ~/.config/bspwm/
    whiptail --msgbox "Installation completed successfully!" 8 50
else
    whiptail --msgbox "Installation canceled." 8 50
fi