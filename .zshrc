# This stops oh-my-zsh from prompting for updates (cuts off the first letter of
# first prompts otherwise)
DISABLE_AUTO_UPDATE="true"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Supress FreeSurfer boilerplate output:
export FS_FREESURFERENV_NO_OUTPUT=1

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="candy"
# ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colorize colored-man-pages)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

export ANTSPATH=$HOME/Programs/ants-2.4.4/bin/

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if $OSTYPE == "linux-gnu"* ]]; then
	alias mango="$HOME/Programs/Mango/mango"
fi

mangoo() {
	mango "$(realpath "$1")"
}

# ANTs
PATH=$HOME/Programs/ants-2.4.4/bin:$PATH
# DCM4CHE
PATH=$HOME/Programs/dcm4che-5.31.0/bin:$PATH
# Freesurfer
export FREESURFER_HOME=/usr/local/freesurfer/7.4.1
export FS_LICENSE=$FREESURFER_HOME/license.txt
source $FREESURFER_HOME/SetUpFreeSurfer.sh
# FastSurfer
export PYTHONPATH="${PYTHONPATH}:${HOME}/Programs/FastSurfer"

# A fucntion to delete empty files of any type from a directory:
function delete_empty_files() {
	local folder="$1"
	if [ -d "$folder" ]; then
		output=$(find "$folder" -type f -empty -print -delete)
		# If there where any empty files, print a message:
		if [ -n "$output" ]; then
			echo "Empty files deleted in $folder."
		else
			echo "No empty files found in $folder."
		fi
	else
		echo "Directory $folder does not exist."
	fi
}
	

# A function to update the journal database:
function git_commit_push() {
	local folder="$1"
	local message="$2"
	if [ -d "$folder" ]; then
		cd "$folder" || return
		# Add everything but hidden files:
		git add --all -- ':!.*' && \
		git commit -m "${message:-'auto update'}" && \
		git push
		cd - > /dev/null || return
	else
		echo "Directory $folder does not exist."
	fi
}

# A function to pull the latest changes from the remote repository:
function git_pull() {
	local folder="$1"
	if [ -d "$folder" ]; then
		cd "$folder" || return
		git pull
		cd - > /dev/null || return
	else
		echo "Directory $folder does not exist."
	fi
}

# An alias to create a new journal entry and back it up:
journal_repo_location="$HOME/Documents/MacDotFiles/journal"
journal_entries_location="$HOME/Documents/MacDotFiles/journal/journals"
if [[ -e $journal_repo_location/make_new_journal_entry.sh ]]; then
	alias "journal"="cd $journal_repo_location; git_pull $journal_repo_location; cd $journal_entries_location; nvim $($journal_repo_location/make_new_journal_entry.sh $1) && delete_empty_files $journal_entries_location && git_commit_push $journal_entries_location 'Wrote to journal' && exit"
fi

# An alias to create a new schedule and back it up:
schedule_repo_location="$HOME/Documents/MacDotFiles/schedule"
schedule_entries_location="$HOME/Documents/MacDotFiles/schedule/schedules"
if [[ -e $schedule_repo_location/make_new_schedule.sh ]]; then
	alias "schedule"="cd $schedule_repo_location; git_pull $schedule_repo_location; cd $schedule_entries_location; nvim $($schedule_repo_location/make_new_schedule.sh $1) && delete_empty_files $schedule_entries_location && git_commit_push $schedule_entries_location 'Wrote to schedule' && exit"
fi

# Personal aliases
alias ll="ls -la"
alias python="python3.13"
alias py="python3.13"
alias ts="trash"
alias venv="source venv/bin/activate"
alias pip="python3.13 -m pip"
alias vim="nvim"
alias t="tree"
alias man="colored man"
alias q="exit"
alias c="clear"
alias g="git"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m '[no message]'"
alias gpl="git pull"
alias gph="git push"
alias dot="cd $HOME/Documents/MacDotFiles"
alias nilw="cd $NILWIZARD_DIR && venv"

MANGOBIN=$HOME/bin; PATH=${MANGOBIN}:${PATH}; export PATH

# LLVM:
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export NVIM_PYTHON_LOG_FILE="$HOME/logs/neovim_python.log"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/Programs/zsh-vim-mode/zsh-vim-mode.plugin.zsh

# ZSH Vim Mode settings
MODE_CURSOR_VIINS="#808080 blinking bar"
MODE_CURSOR_NORMAL="$MODE_CURSOR_VIINS steady block"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VIINS steady bar"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #008080"
MODE_CURSOR_REPLACE="$MODE_CURSOR_VISUAL #800000"
MODE_CURSOR_VICMD="green block"
MODE_CURSOR_SEARCH="#800080 steady underline"
KEYTIMEOUT=1
# Disable the "execute" mode in vim-mode:
VIM_MODE_EXECUTE_BINDINGS=()

# Remove the "Esc-b" Emacs binding as it conflicts with vim-mode:
bindkey -r '\eb'

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/Library/Python/3.13/bin:$PATH"

# check if we are on linux or macos:
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	# linux
	export NVM_DIR="$HOME/.nvm"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	# macOS
	export NVM_DIR="/opt/homebrew/opt/nvm/"
fi
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	# linux
fi
