# Ubuntu terminal enhancer

This repository contains a Bash script (`install_ubuntu_p10k.sh`) that automates the installation of essential tools and configurations for a productive Zsh environment on Ubuntu. The script installs Git, Zsh, Oh My Zsh, the Powerlevel10k theme, and some useful plugins.

## Prerequisites

Before running the script, ensure you have the following:

- A terminal with access to the internet.
- Sudo privileges to install packages.

## Usage

1. **Clone the Repository**

   You can clone the repository containing the script using `git`. Open your terminal and run:

   ```bash
   git clone https://github.com/coder8matic/ubuntu-terminal-enhancer.git
   ```

   After cloning, navigate to the directory:

   ```bash
   cd ubuntu-terminal-enhancer
   ```

2. **Make the Script Executable**

   After downloading, you need to make the script executable. Run the following command:

   ```bash
   chmod +x install_ubuntu_p10k.sh
   ```

3. **Run the Script**

   Now, you can execute the script. Use the following command:

   ```bash
   ./install_ubuntu_p10k.sh
   ```

   When the script stops after installing Oh My Zsh, you can `exit` the zsh terminal and then the script will continue with the installation process.

   The script will perform the following steps:
   - Check for and install Git if it's not already installed.
   - Install Zsh if it's not already installed.
   - Install Oh My Zsh if it's not already installed.
   - Install the Powerlevel10k theme.
   - Install additional custom plugins for Oh My Zsh.
   - Update your `.zshrc` configuration file to use Powerlevel10k and the installed plugins.

4. **Restart Your Terminal**

   After the installation is complete, restart your terminal to apply the changes.

## Troubleshooting

- If you encounter any issues during the installation, check the terminal output for error messages.
- Ensure you have a stable internet connection, as the script downloads packages and themes from the internet.

## License

This script is open-source and available for modification and redistribution. Please refer to the license file for more details.

## Acknowledgments

- Thanks to the contributors of Oh My Zsh and Powerlevel10k for their amazing work!
