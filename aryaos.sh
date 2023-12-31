echo "Welcome to the AryaOS Installer Script! The installation will begin in 5 seconds..."
sleep 5
wget -O- https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt update
sudo apt full-upgrade -y
sudo apt-add-repository universe multiverse -y
sudo add-apt-repository ppa:apt-fast/stable -y
sudo apt update
sudo apt install apt-fast -y
sudo apt-fast install stacer preload gimp pitivi simplescreenrecorder flameshot signal-desktop kdeconnect gnome-tweaks papirus-icon-theme htop git chrome-gnome-shell gnome-shell-extension-manager -y
sudo systemctl enable --now preload
wget https://raw.githubusercontent.com/crazycheetah42/AryaOS/master/ainstall
sudo mv ainstall /usr/bin/
sudo chmod +x /usr/bin/ainstall
sudo mkdir -p /packages/aryaos/
sudo mkdir -p /packagerepos/aryaos/
ainstall update
export PATH=$PATH:/packages/aryaos
echo "The installer is finished. See After Installation on the AryaOS website to customize your system further!"
