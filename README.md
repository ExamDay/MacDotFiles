In order:
1. Install Neovim
1. Copy the nvim folder into your ~/.config folder
1. Install Vundle the normal way (see the github)
1. Copy .vimrc to your homefolder and comment out the copilot plugin if you don't want it.
1. Install all the plugins by :PluginInstall
1. Complete the second half of YouCompleteMe installation by following the directions on its Github.
1. Maybe get github Copilot but that does cost money.

- Optionally: set an alias in your .bashrc like
  ```Bash
  alias vim="nvim"
  ```
- If you are in a venv, go to open a file, and you see a complaint like "X not available / vim needs to be compiled with python version blah blah blah" just do pip3 install neovim inside the venv.
