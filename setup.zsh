#!/bin/zsh
# Make the ~/Programs directory if it doesn't exist:
mkdir -p ~/Programs
# Change to the ~/Programs directory:
cd ~/Programs
# Clone the zsh-syntax-highlighting repository if it doesn't exist:
if [ ! -d "zsh-syntax-highlighting" ]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
fi
# Clone the zsh-vim-mode repository if it doesn't exist:
if [ ! -d "zsh-vim-mode" ]; then
	git clone https://github.com/softmoth/zsh-vim-mode.git
fi
cd ~

if [[ $OSTYPE == darwin* ]]; then
	# Install hammerspoon:
	brew install hammerspoon
	mkdir ~/.hammerspoon
	ln -s ~/Documents/MacDotFiles/.hammerspoon/init.lua ~/.hammerspoon/init.lua
	# The rest of hammerspoon setup must be done by starting the program from
	# Launchpad or Spotlight Search
	# Install neovim:
	brew install neovim
else if [[ $OSTYPE == linux* ]]; then
	# Install zsh:
	sudo apt install zsh
	# Install neovim:
	# curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	# sudo rm -rf /opt/nvim-linux-x86_64
	# sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
else
	echo "Unsupported OS type: $OSTYPE"
	exit 1
fi

# Install ohmyzsh:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Copy the vundle.vimrc to .vimrc:
mv ~/.vimrc ~/backup.vimrc
cp ./vundle.vimrc ~/.vimrc
vim +PluginInstall +qall
# Delete the vundle-install .vimrc and replace it with a link to the up-to-date vimrc:
rm ~/.vimrc
ln -s ~/Documents/MacDotFiles/.vimrc ~/.vimrc
vim +PluginInstall +qall

# Make the neovim .config stuff:
mkdir -p ~/.config/nvim/lua/user
ln -s ~/Documents/MacDotFiles/.config/nvim/init.lua ~/.config/nvim/init.lua
ln -s ~/Documents/MacDotFiles/.config/nvim/lua/user/plugins.lua ~/.config/nvim/lua/user/plugins.lua
ln -s ~/Documents/MacDotFiles/.config/nvim/lua/user/cmp.lua ~/.config/nvim/lua/user/cmp.lua
ln -s ~/Documents/MacDotFiles/.config/nvim/lua/user/toggleterm.lua ~/.config/nvim/lua/user/toggleterm.lua

# At this point you need to go into
# ~/Documents/MacDotFiles/.config/nvim/lua/user/plugins.lua and do :w twice to
# install all the neovim plugins...
# Can this be done automatically?

# Change to the directory where nvim-cmp is installed:
cd ~/.local/share/nvim/site/pack/packer/start/nvim-cmp
# Fetch the pull request where the "put menu above the cursor" feature is
# implemented:
git fetch origin pull/1701/head:feat/above
# Switch to the new branch:
git checkout feat/above
# Go back to the home directory:
cd ~

# Link the zshrc to .zshrc:
mv ~/.zshrc ~/backup.zshrc
ln -s ~/Documents/MacDotFiles/.zshrc ~/.zshrc

