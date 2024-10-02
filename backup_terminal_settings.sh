#!/bin/bash

# Path to the backup tar file (assumes it's in your home directory)
BACKUP_FILE=~/New-Kali-Setup-Script-main/terminal_backup.tar.gz

# Check if the backup file exists
if [ ! -f "$BACKUP_FILE" ]; then
    echo "Backup file not found: $BACKUP_FILE"
    exit 1
fi

# Extract the backup file
echo "Extracting backup..."
tar -xzvf "$BACKUP_FILE" -C ~/

# Path to extracted backup directory
BACKUP_DIR=~/terminal_backup

# Check if the backup directory exists
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Backup directory not found after extraction: $BACKUP_DIR"
    exit 1
fi

# Restore Zsh configuration files
if [ -f "$BACKUP_DIR/.zshrc" ]; then
    cp "$BACKUP_DIR/.zshrc" ~/
fi

if [ -f "$BACKUP_DIR/.zprofile" ]; then
    cp "$BACKUP_DIR/.zprofile" ~/
fi

if [ -f "$BACKUP_DIR/.zshenv" ]; then
    cp "$BACKUP_DIR/.zshenv" ~/
fi

if [ -f "$BACKUP_DIR/.zsh_history" ]; then
    cp "$BACKUP_DIR/.zsh_history" ~/
fi

# Restore Bash configuration files
if [ -f "$BACKUP_DIR/.bashrc" ]; then
    cp "$BACKUP_DIR/.bashrc" ~/
fi

if [ -f "$BACKUP_DIR/.bash_profile" ]; then
    cp "$BACKUP_DIR/.bash_profile" ~/
fi

if [ -f "$BACKUP_DIR/.profile" ]; then
    cp "$BACKUP_DIR/.profile" ~/
fi

if [ -f "$BACKUP_DIR/.bash_history" ]; then
    cp "$BACKUP_DIR/.bash_history" ~/
fi

# Restore additional directories (like ~/bin)
if [ -d "$BACKUP_DIR/bin" ]; then
    cp -r "$BACKUP_DIR/bin" ~/
fi

# Restore GNOME Terminal settings (if applicable)
if [ -f "$BACKUP_DIR/gnome-terminal-settings.txt" ] && command -v dconf &> /dev/null; then
    dconf load /org/gnome/terminal/ < "$BACKUP_DIR/gnome-terminal-settings.txt"
fi

# Clean up the extracted backup directory
rm -rf "$BACKUP_DIR"

# Source configuration files to apply changes
if [ -f ~/.zshrc ]; then
    echo "Sourcing .zshrc"
    source ~/.zshrc
fi

if [ -f ~/.bashrc ]; then
    echo "Sourcing .bashrc"
    source ~/.bashrc
fi

echo "Restore completed!"

zellij options --disable-mouse-mode
