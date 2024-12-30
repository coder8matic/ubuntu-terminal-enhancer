#!/bin/bash

# Uninstall script to remove environment setup on Ubuntu Server

# Step 0: Uninstall custom plugins for Oh My Zsh
echo "Step 0: Uninstalling custom plugins for Oh My Zsh..."
additional_plugins=(
    "zsh-syntax-highlighting"
    "zsh-autosuggestions"
    "zsh-history-substring-search"
)

for plugin in "${additional_plugins[@]}"; do
    PLUGIN_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$plugin"
    if [ -d "$PLUGIN_DIR" ]; then
        echo "Removing $plugin..."
        rm -rf "$PLUGIN_DIR"
    else
        echo "$plugin is not installed."
    fi
done

# Step 1: Remove Powerlevel10k theme
echo "Step 1: Removing Powerlevel10k theme..."
POWERLEVEL10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ -d "$POWERLEVEL10K_DIR" ]; then
    rm -rf "$POWERLEVEL10K_DIR"
    echo "Powerlevel10k theme removed."
else
    echo "Powerlevel10k theme is not installed."
fi

# Step 2: Remove Oh My Zsh
echo "Step 2: Removing Oh My Zsh..."
OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"
if [ -d "$OH_MY_ZSH_DIR" ]; then
    rm -rf "$OH_MY_ZSH_DIR"
    echo "Oh My Zsh removed."
else
    echo "Oh My Zsh is not installed."
fi

# Step 3: Uninstall Zsh
echo "Step 3: Uninstalling Zsh..."
if command -v zsh &> /dev/null; then
    sudo apt remove --purge -y zsh
    echo "Zsh uninstalled."
else
    echo "Zsh is not installed."
fi

# Step 4: Uninstall Git
echo "Step 4: Uninstalling Git..."
if command -v git &> /dev/null; then
    sudo apt remove --purge -y git
    echo "Git uninstalled."
else
    echo "Git is not installed."
fi

# Step 5: Clean up .zshrc
echo "Step 5: Cleaning up .zshrc..."
if [ -f "$HOME/.zshrc" ]; then
    # Remove Powerlevel10k and plugins from .zshrc
    sed -i '/^ZSH_THEME="powerlevel10k\/powerlevel10k"/d' ~/.zshrc
    for plugin in "${additional_plugins[@]}"; do
        sed -i "/$plugin/d" ~/.zshrc
    done
    echo ".zshrc cleaned up."
else
    echo ".zshrc not found."
fi

# Step 6: Final message
echo "Uninstallation complete. Please restart your terminal."