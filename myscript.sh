#!/bin/bash
echo "============================================================"
echo "My personal script to setup a new VM"
echo "Installing common tools"
echo "============================================================"


sudo apt update && sudo apt dist-upgrade -y
sudo apt install wget curl zsh tmux dirsearch feroxbuster vim remmina terminator openjdk-17-jdk npm neo4j bloodhound -y
sudo apt update && sudo apt install pipx

echo "============================================================"
echo "Installing OS dependens"
echo "============================================================"
sudo apt-get install -y libxcb-shape0-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev autoconf meson
sudo apt-get install -y libxcb-render-util0-dev libxcb-shape0-dev libxcb-xfixes0-dev

echo "============================================================"
echo "Installing tools"
echo "============================================================"
sudo apt -y install code-oss

echo "============================================================"
echo "Installing tools"
echo "============================================================"
pip3 install certipy-ad
python3 -m pipx install impacket

echo "============================================================"
echo "Installing Sublime"
echo "============================================================"
sleep 5
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

echo "============================================================"
echo "Installing Brave"
echo "============================================================"
sleep 5
sudo apt install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser -y

# Create a Tools folder in Home ~/
echo "============================================================"
echo -e "\e[93m\e[1m----> Create a Tools folder"
echo "============================================================"
sleep 5
mkdir ~/tools
cd ~/tools/
echo -e "\e[32mDone!"; echo "";
sleep 1.5

echo "============================================================"
echo "Installing Exegol"
echo "============================================================"
sleep 5
curl -fsSL "https://get.docker.com/" | sh
# add the sudo group to the user
sudo usermod -aG docker $(id -u -n)
# "reload" the user groups with the newly added docker group
newgrp docker
# install pipx if not already installed, from system package:
sudo apt update && sudo apt install pipx
# OR from pip
python3 -m pip install pipx
# You can now install Exegol package from PyPI
pipx install exegol
pipx ensurepath
echo "alias exegol='sudo -E $(which exegol)'" >> ~/.zshrc
source ~/.zshrc
autoload -U compinit
compinit
eval "$(register-python-argcomplete --no-defaults exegol)"


echo "============================================================"
echo "Installing Havoc"
echo "============================================================"
sleep 5
cd ~/tools
git clone https://github.com/HavocFramework/Havoc.git
cd Havoc
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.10 python3.10-dev
sudo apt install -y git build-essential apt-utils cmake libfontconfig1 libglu1-mesa-dev libgtest-dev libspdlog-dev libboost-all-dev libncurses5-dev libgdbm-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev libbz2-dev mesa-common-dev qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools libqt5websockets5 libqt5websockets5-dev qtdeclarative5-dev golang-go qtbase5-dev libqt5websockets5-dev python3-dev libboost-all-dev mingw-w64 nasm
cd teamserver
go mod download golang.org/x/sys
go mod download github.com/ugorji/go
cd ..
make ts-build
make client-build

echo "============================================================"
echo "Installing zellij"
echo "============================================================"
wget https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz
tar -xzvf zellij-x86_64-unknown-linux-musl.tar.gz
sudo cp zellij /usr/bin/zellij


#optional
echo "============================================================"
echo "Moving VPN files"
echo "============================================================"
mv vpn ~/vpn
mv .tmux.conf ~/.tmux.conf
mv config ~/.config/terminator/config





read -p "Do you want to reinistall impacket (y/n): " choice

if [[ $choice == "y" ]]; then
	sudo apt remove impacket-scripts -y
	sudo apt remove python3-impacket -y
        sudo apt install pipx -y
	python3 -m pipx install impacket
fi

echo "============================================================"
echo "Doing some clean up"
echo "============================================================"

sudo apt autoremove && sudo apt autoclean -y


echo "============================================================"
echo "Installing Oh-My-ZSH"
echo "============================================================"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp .zshrc ~/.zshrc

## Might have to restart the script
echo "============================================================"
echo "Plugins for ZSH"
echo "============================================================"
#autosuggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions



echo "GG DONE"
