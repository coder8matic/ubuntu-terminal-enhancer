#!/bin/bash

# Bash script to setup environment on Ubuntu Server
# - git
# - zsh
# - Powerlevel10k
# - custom plugins for Oh My Zsh

# Step 0: Check if Git is installed
echo "Step 0: Checking for Git installation..."
if ! git --version &> /dev/null; then
    echo "Git is not installed. Installing Git..."
    sudo apt update && sudo apt install -y git
else
    echo "Git is already installed."
fi

# Step 1: Install Zsh
echo "Step 1: Installing Zsh..."
if ! command -v zsh &> /dev/null; then
    sudo apt install -y zsh
    echo "Zsh installed successfully!"
else
    echo "Zsh is already installed."
fi

# Install Oh My Zsh
echo "Step 2: Installing Oh My Zsh..."
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh is already installed."
else
  # Install Oh My Zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  if [ $? -eq 0 ]; then
    echo "Oh My Zsh installed successfully!"
  else
    echo "Oh My Zsh installation failed. Please check for errors above."
    exit 1
  fi
fi

# Step 3: Install Powerlevel10k theme
echo "Step 3: Installing Powerlevel10k theme..."
if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "Powerlevel10k theme is already installed."
else
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

  if [ $? -eq 0 ]; then
    echo "Powerlevel10k theme installed successfully!"

    # Copy the custom .p10k.zsh configuration file from the config directory
    cp ./config/.p10k.zsh ~/.p10k.zsh

    # Ensure .zshrc is updated to source .p10k.zsh
    if ! grep -q 'source ~/.p10k.zsh' ~/.zshrc; then
      echo 'source ~/.p10k.zsh' >> ~/.zshrc
      echo "Updated .zshrc to source .p10k.zsh."
    fi

    # Ensure ZSH_THEME is set for Powerlevel10k
    if ! grep -q 'ZSH_THEME="powerlevel10k/powerlevel10k"' ~/.zshrc; then
      sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
      echo "Set ZSH_THEME to Powerlevel10k in .zshrc."
    fi
  else
    echo "Powerlevel10k theme installation failed. Please check for errors above."
    exit 1
  fi
fi

# Step 4: Install custom plugins for Oh My Zsh
echo "Step 4: Installing custom plugins for Oh My Zsh..."
additional_plugins=(
    "zsh-syntax-highlighting"
    "zsh-autosuggestions"
    "zsh-history-substring-search"
)

# Check if the plugins line exists
if grep -q "plugins=(" ~/.zshrc; then
    # Move the opening parenthesis to a new line if there is content after it
    sed -i "/^plugins=(\s*[^)]/s/^plugins=(\s*/plugins=(\n    /" ~/.zshrc

    # Find the first line after plugins=( that ends with )
    sed -i "/^plugins=(/,/)/ { /)$/! { N; }; /.*[^ ]$/ s/\(.*[^ ]\)\()$\)/\1\n\2/; }" ~/.zshrc
fi

# Add additional plugins before the closing parenthesis
for plugin in "${additional_plugins[@]}"; do
    # Define the plugin directory
    PLUGIN_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$plugin"

    # Clone the plugin repository if it doesn't exist
    if [ ! -d "$PLUGIN_DIR" ]; then
        echo "Installing $plugin..."
        git clone "https://github.com/zsh-users/$plugin.git" "$PLUGIN_DIR"
    else
        echo "$plugin is already installed."
    fi

    # Add plugin into ~/.zshrc
    if ! grep -q "$plugin" ~/.zshrc; then
        # Insert the plugin before the first closing parenthesis after plugins=(
        sed -i "/^plugins=(/,/)/ { /)/ s/)/    $plugin\n)/; }" ~/.zshrc
    fi
done

echo "Plugins have been added to .zshrc."

# Source zshrc using zsh
exec zsh -l

# Step 5: Final message
echo "Step 5: Installation complete. Please restart your terminal for changes to take effect."
