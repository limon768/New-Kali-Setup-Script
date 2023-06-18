#!/bin/bash
echo "My personal script to setup a new VM"

echo "Installing common tools"
sleep 5

sudo apt update && sudo apt dist-upgrade -y

sudo apt install wget curl zsh tmux dirsearch vim remmina terminator

echo "Installing VsCode"
sudo apt -y install code-oss

echo "Installing Sublime"
sleep 5
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

echo "Installing Brave"
sleep 5
sudo apt install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser -y

#optional
echo "Moving VPN files"
mv vpn ~/vpn
mv .tmux.conf ~/.tmux.conf
mv config ~/.config/terminator/config

echo "Installing Oh-My-ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp .zshrc ~/.zshrc

echo "Plugins for ZSH"
#autosuggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

#syntaxhighlighter
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

read -p "Do you want to reinistall impacket (y/n): " choice

if [[ $choice == "y" ]]; then
	sudo apt remove impacket-scripts
	sudo apt remove python3-impacket
        sudo apt install pipx -y
	python3 -m pipx install impacket
fi



echo "GG DONE"
