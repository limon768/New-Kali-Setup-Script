#!/bin/bash
echo "============================================================"
echo "My personal script to setup a new VM"
echo "Installing common tools"
echo "============================================================"


sudo apt update && sudo apt dist-upgrade -y
sudo apt install wget curl zsh tmux dirsearch vim remmina terminator openjdk-17-jdk -y

echo "============================================================"
echo "Installing VsCode"
echo "============================================================"
sudo apt -y install code-oss

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
