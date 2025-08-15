vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
]])

require "user.plugins"
require "user.toggleterm"

vim.g.copilot_workspace_folders = {
	"~/Desktop/puppetlegion/puppetlegion"
}

require "user.cmp"
