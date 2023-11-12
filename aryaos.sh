echo "Welcome to the AryaOS Installer Script!"
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
cd /usr/share/themes
sudo wget https://github.com/crazycheetah42/AryaOS/releases/download/v1.0.0/Orchis-Grey.tar.xz
sudo tar -xvf Orchis-Grey.tar.xz
sudo rm -r Orchis-Grey.tar.xz
cd ~
gsettings set org.gnome.desktop.interface gtk-theme "Orchis-Grey-Light"
