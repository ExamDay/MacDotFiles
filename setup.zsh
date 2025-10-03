#!/bin/zsh
# Make the $HOME/Programs directory if it doesn't exist:
mkdir -p $HOME/Programs
# Change to the $HOME/Programs directory:
cd $HOME/Programs
# Clone the zsh-syntax-highlighting repository if it doesn't exist:
if [ ! -d "zsh-syntax-highlighting" ]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
fi
# Clone the zsh-vim-mode repository if it doesn't exist:
if [ ! -d "zsh-vim-mode" ]; then
	git clone https://github.com/softmoth/zsh-vim-mode.git
fi

cd $HOME

if [[ "$OSTYPE" == "darwin"* ]]; then
	# Install hammerspoon:
	brew install hammerspoon
	mkdir $HOME/.hammerspoon
	ln -s $HOME/Documents/MacDotFiles/.hammerspoon/init.lua $HOME/.hammerspoon/init.lua
	# The rest of hammerspoon setup must be done by starting the program from
	# Launchpad or Spotlight Search
	# Install neovim:
	brew install neovim
elif [[ $OSTYPE == "linux-gnu"* ]]; then
	# Install zsh:
	# sudo apt install zsh
	# Install neovim:
	# curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	# sudo rm -rf /opt/nvim-linux-x86_64
	# sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
fi

# Install ohmyzsh:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install vundle:
git clone git@github.com:VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
# Copy the vundle.vimrc to .vimrc:
mv $HOME/.vimrc $HOME/backup.vimrc
cp $HOME/Documents/MacDotFiles/vundle.vimrc $HOME/.vimrc
vim +PluginInstall +qall
# Delete the vundle-install .vimrc and replace it with a link to the up-to-date vimrc:
rm $HOME/.vimrc
ln -s $HOME/Documents/MacDotFiles/.vimrc $HOME/.vimrc
vim +PluginInstall +qall

# Make the neovim .config stuff:
mkdir -p $HOME/.config/nvim/lua/user
ln -s $HOME/Documents/MacDotFiles/.config/nvim/init.lua $HOME/.config/nvim/init.lua
ln -s $HOME/Documents/MacDotFiles/.config/nvim/lua/user/plugins.lua $HOME/.config/nvim/lua/user/plugins.lua
ln -s $HOME/Documents/MacDotFiles/.config/nvim/lua/user/cmp.lua $HOME/.config/nvim/lua/user/cmp.lua
ln -s $HOME/Documents/MacDotFiles/.config/nvim/lua/user/toggleterm.lua $HOME/.config/nvim/lua/user/toggleterm.lua

# At this point you need to go into
# $HOME/.config/nvim/lua/user/plugins.lua and do :w twice to
# install all the neovim plugins...
# Can this be done automatically?

# Change to the directory where nvim-cmp is installed:
cd $HOME/.local/share/nvim/site/pack/packer/start/nvim-cmp
# Fetch the pull request where the "put menu above the cursor" feature is
# implemented:
git fetch origin pull/1701/head:feat/above
# Switch to the new branch:
git checkout feat/above
# Go back to the home directory:
cd $HOME

# Link the zshrc to .zshrc:
mv $HOME/.zshrc $HOME/backup.zshrc
ln -s $HOME/Documents/MacDotFiles/.zshrc $HOME/.zshrc

