#!/bin/bash
echo "============================================================"
echo "My personal script to setup a new VM"
echo "Installing common tools"
echo "============================================================"


sudo apt update && sudo apt dist-upgrade -y
sudo apt install wget curl zsh tmux dirsearch feroxbuster vim remmina terminator openjdk-17-jdk npm neo4j bloodhound netexec keepassxc rlwrap golang -y
sudo apt update && sudo apt install pipx

echo "============================================================"
echo "Installing OS dependens"
echo "============================================================"
sudo apt-get install -y libxcb-shape0-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev autoconf meson
sudo apt-get install -y libxcb-render-util0-dev libxcb-shape0-dev libxcb-xfixes0-dev

# Create a Tools folder in Home ~/
echo "============================================================"
echo "Create a Tools folder"
echo "============================================================"
sleep 5
mkdir ~/tools
cd ~/tools/
echo -e "\e[32mDone!"; echo "";
sleep 1.5

echo "============================================================"
echo "Installing tools"
echo "============================================================"
sudo apt -y install code-oss
pip3 install certipy-ad
pip3 install bloodyAD
sudo python3 -m pip install coercer
python3 -m pipx install impacket
go install github.com/cmepw/myph@latest

echo "[+] Installing gMSADumper"

git clone https://github.com/micahvandeusen/gMSADumper.git
cd gMSADumper
pip3 install -r requirements.txt
sudo ln -s /home/sz/tools/gMSADumper/gMSADumper.py /usr/local/bin/gMSADumper.py
cd -

echo "[+] Installing LAPSDumper"
git clone https://github.com/n00py/LAPSDumper.git
cd LAPSDumper
pip3 install -r requirements.txt
sudo ln -s /home/sz/tools/LAPSDumper/laps.py /usr/local/bin/laps.py
cd -

echo "[+] Installing pyGPOAbuse"
git clone https://github.com/Hackndo/pyGPOAbuse.git
cd pyGPOAbuse
pip3 install -r requirements.txt
sudo ln -s /home/sz/tools/pyGPOAbuse/pygpoabuse.py /usr/local/bin/pygpoabuse.py
cd -

echo "[+] Installing pywhisker"
git clone https://github.com/ShutdownRepo/pywhisker.git
cd pywhisker
pip3 install -r requirements.txt
sudo ln -s /home/sz/tools/pywhisker/pywhisker.py /usr/local/bin/pywhisker.py
cd -

echo "[+] Installing targetedKerberoast"
git clone https://github.com/ShutdownRepo/targetedKerberoast.git
cd targetedKerberoast
pip3 install -r requirements.txt
sudo ln -s /home/sz/tools/targetedKerberoast/targetedKerberoast.py /usr/local/bin/targetedKerberoast.py
cd -

git clone https://github.com/brightio/penelope.git
cd penelope
pip3 install -r requirements.txt
sudo ln -s /home/sz/tools/penelope/penelope.py /usr/local/bin/penelope.py
cd -


git clone https://github.com/topotam/PetitPotam.git

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
sleep 5

echo "============================================================"
echo "Installing Exegol"
echo "============================================================"
sleep 5
curl -fsSL "https://get.docker.com/" | sh
sudo apt install -y docker.io
sudo systemctl enable docker --now
sudo usermod -aG docker $(whoami)
groups $(whoami)
newgrp docker
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
cd ~/tools

echo "============================================================"
echo "Installing zellij"
echo "============================================================"
wget https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz
tar -xzvf zellij-x86_64-unknown-linux-musl.tar.gz
sudo cp zellij /usr/bin/zellij
rm ~/tools/zelli*


#optional
echo "============================================================"
echo "Moving VPN files"
echo "============================================================"
mv vpn ~/vpn
mv .tmux.conf ~/.tmux.conf
mv config ~/.config/terminator/config



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
echo "Opening ZELLIJ"
echo "============================================================"
zellij options --disable-mouse-mode

## Might have to restart the script
echo "============================================================"
echo "Plugins for ZSH"
echo "============================================================"
#autosuggestion
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/sz/.oh-my-zsh/zsh-syntax-highlighting/


echo "GG DONE"
