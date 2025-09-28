#!/bin/zsh
# Make the ~/Programs directory if it doesn't exist:
mkdir -p ~/Programs
# Change to the ~/Programs directory:
cd ~/Programs
# Clone the zsh-autosuggestions repository if it doesn't exist:
if [ ! -d "zsh-autosuggestions" ]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions.git
fi
# Clone the zsh-syntax-highlighting repository if it doesn't exist:
if [ ! -d "zsh-syntax-highlighting" ]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
fi
# Clone the zsh-vim-mode repository if it doesn't exist:
if [ ! -d "zsh-vim-mode" ]; then
	git clone https://github.com/softmoth/zsh-vim-mode.git
fi
cd ~

# Change to the directory where nvim-cmp is installed:
cd ~/.local/share/nvim/site/pack/packer/start/nvim-cmp
# Fetch the pull request where the "put menu above the cursor" feature is implemented:
git fetch origin pull/1701/head:feat/above
# Switch to the new branch:
git checkout feat/above
# Go back to the home directory:
cd ~
