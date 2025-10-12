# This stops freesurfer from printin its directory every time a new shell is opened:
export FS_FREESURFERENV_NO_OUTPUT=1
# This stops oh-my-zsh from prompting for updates (cuts off the first letter of
# first prompts otherwise)
DISABLE_AUTO_UPDATE="true"
# Sets the strategy for zsh-autosuggestions:
ZSH_AUTOSUGGEST_STRATEGY=(history completion)  # (this first checks the history, then the completions)

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#

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

### User ZSH Settings:
# Enable extended history with timestamp:
setopt EXTENDED_HISTORY
# Share history between all sessions:
setopt SHARE_HISTORY
# Make history infinitely large:
HISTSIZE=100000

### Some OS/Workstation Specific settings:
if [[ $OSTYPE == "linux-gnu"* ]]; then
	# You may need to manually set your language environment
	export LANG=en_US.UTF-8
	# Set Mango alias for linux:
	alias mango="$HOME/Programs/Mango/mango"
	# Supress FreeSurfer boilerplate output:
	export FS_FREESURFERENV_NO_OUTPUT=1

elif [[ "$OSTYPE" == "darwin"* ]]; then
	# Set mangobin directory for macOS:
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
fi

mangoo() {
	mango "$(realpath "$1")"
}

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


# Define a function that will return the path of the given file relative to the
# repo root:
function repo_relative_path() {
	local file_path="$1"
	# Check if the file exists:
	if [ -f "$file_path" ]; then
		# Get the absolute path of the file:
		local abs_path=$(realpath "$file_path")
		# Get the git repo root:
		local repo_root=$(git -C "$(dirname "$abs_path")" rev-parse --show-toplevel 2> /dev/null)
		# If the repo root was found, print the relative path:
		if [ -n "$repo_root" ]; then
			# local rel_path=$(realpath --relative-to="$repo_root" "$abs_path")
			# ^ realpath cannot be used this way on macOS, so use parameter
			# expansion instead:
			local rel_path="${abs_path#$repo_root/}"
			echo "$rel_path"
		else
			echo "Repo root not found for file $file_path." >&2
			return 1
		fi
	else
		echo "File $file_path does not exist." >&2
	fi
}
# Make a function that runs "git show" using "repo_relative_path" to get the path
# for the second argument:
function git_show_rel() {
	local branch_name
	local file_path
	branch_name="$1"
	file_path="$2"
	if [ -z "$branch_name" ] || [ -z "$file_path" ]; then
		echo "Usage: git_show_rel <branch_name> <file_path>" >&2
		return 1
	fi
	local rel_path
	rel_path=$(repo_relative_path "$file_path")
	if [ $? -ne 0 ]; then
		return 1
	fi
	git show "$branch_name:$rel_path"
}
# Make and alias for the above function:
alias gnab="git_show_rel"

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
alias nvimconfig="cd $HOME/.config/nvim && ll"

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
# Disavle the "z" and "Z" bindings in normal mode

# Remove the "Esc-b" Emacs binding as it conflicts with vim-mode:
bindkey -r '\eb'

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/Library/Python/3.13/bin:$PATH"

# OS Specific nnUNet setup:
if [[ $OSTYPE == "linux-gnu"* ]]; then
	# export nnUNet_raw="$HOME/mri_image_processing/rsna_iad/nnUNet_data/nnUNet_raw"
	# export nnUNet_preprocessed="$HOME/mri_image_processing/rsna_iad/nnUNet_data/nnUNet_preprocessed"
	# export nnUNet_results="$HOME/mri_image_processing/rsna_iad/nnUNet_data/nnUNet_results"

	export nnUNet_raw="/media/physics/DATADRIVE1/RSNA_Aneurysm_2025/nnUNet_data/nnUNet_raw"
	export nnUNet_preprocessed="/media/physics/DATADRIVE1/RSNA_Aneurysm_2025/nnUNet_data/nnUNet_preprocessed"
	export nnUNet_results="/media/physics/DATADRIVE1/RSNA_Aneurysm_2025/nnUNet_data/nnUNet_results"

elif [[ "$OSTYPE" == "darwin"* ]]; then
	export nnUNet_raw="$HOME/Desktop/rsna_iad_challenge/nnUNet_data/nnUNet_raw"
	export nnUNet_preprocessed="$HOME/Desktop/rsna_iad_challenge/nnUNet_data/nnUNet_preprocessed"
	export nnUNet_results="$HOME/Desktop/rsna_iad_challenge/nnUNet_data/nnUNet_results"

	export PATH=${PATH}:/opt/homebrew/opt/python/libexec/bin
	eval "$(/opt/homebrew/bin/brew shellenv)"
	export R_LIBS=$HOME/sw/R-4.3.1
fi

# OS Specific NVM setup:
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	# linux
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
elif [[ "$OSTYPE" == "darwin"* ]]; then
	# macOS
	export NVM_DIR="/opt/homebrew/opt/nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	  [ -s "$NVM_DIR/etc/bash_completion.d/nvm" ] && \. "$NVM_DIR/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
	# PostgreSQL 18:
	export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"
fi

function unbind_vicmd_keys() {
	# This is for unbinding certain keys in the vicmd keymap when zsh-vim-mode is
	# enabled, because they conflict with my muscle memory from using vim:
	bindkey -M vicmd ':' undefined-key
	bindkey -M vicmd 'z' undefined-key
	bindkey -M vicmd 'Z' undefined-key
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	# Remap Keys
	# swap capslock and esc keys for quicker vim, because caps is useful only for communicating aggression on the internet. (but this is still important so we dont want to eliminate it entirely)
	# setxkbmap -option caps:swapescape
	# increase repetition rate on hold-key
	# xset r rate 300 75

	# Add the cuda binaries to the PATH:
	PATH=/usr/local/cuda-13.0/bin:$PATH

	# Set ANTSPATH for linux:
	export ANTSPATH=$HOME/Programs/ants-2.4.4/bin/
	# ANTs
	PATH=$HOME/Programs/ants-2.4.4/bin:$PATH
	# DCM4CHE
	PATH=$HOME/Programs/dcm4che-5.31.0/bin:$PATH
	# Freesurfer
	FREESURFER_HOME=/usr/local/freesurfer/7.4.1
	# Only duck with freesurfer if its home directory actually exists:
	if [ -d "$FREESURFER_HOME" ]; then
		export FREESURFER_HOME
		export FS_LICENSE=$FREESURFER_HOME/license.txt
		source $FREESURFER_HOME/SetUpFreeSurfer.sh
		# FastSurfer
		export PYTHONPATH="${PYTHONPATH}:${HOME}/Programs/FastSurfer"
	fi

	export PATH=$HOME/Programs/dcm2niix/bin:$PATH
	export PATH=$HOME/Programs/trackvis:$PATH
	export PATH=$HOME/Programs/dtk:$PATH

	# auto-inserted by @update.afni.binaries :
	export PATH=$PATH:$HOME/abin

	# auto-inserted by @update.afni.binaries :
	#    set up tab completion for AFNI programs
	if [ -f $HOME/.afni/help/all_progs.COMP.zsh ]; then
	   autoload -U +X bashcompinit && bashcompinit
	   autoload -U +X compinit && compinit \
		  && source $HOME/.afni/help/all_progs.COMP.zsh
	fi

	# Check if "/opt/nvim-linux-x86_64/bin" exists, and if so add it to the PATH
	if [ -d "/opt/nvim-linux-x86_64/bin" ]; then
		export PATH="/opt/nvim-linux-x86_64/bin:$PATH"
	fi

	source $HOME/Programs/zsh-autosuggestions/zsh-autosuggestions.zsh
	source $HOME/Programs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	# Check if the user-name is in the list of shared users, if not then run
	# the personal user setup:
	shared_users=("physics" "neuro")
	if [[ ! " ${shared_users[@]} " =~ " $(whoami) " ]]; then
		source $HOME/Programs/zsh-vim-mode/zsh-vim-mode.plugin.zsh && unbind_vicmd_keys
	else
		alias vimode="source $HOME/Programs/zsh-vim-mode/zsh-vim-mode.plugin.zsh && unbind_vicmd_keys"
		alias v="vimode"
	fi

elif [[ "$OSTYPE" == "darwin"* ]]; then
	# auto-inserted by @update.afni.binaries :
	export PATH=$PATH:$HOME/abin

	# auto-inserted by @update.afni.binaries :
	#    set up tab completion for AFNI programs
	if [ -f $HOME/.afni/help/all_progs.COMP.zsh ]; then
	   autoload -U +X bashcompinit && bashcompinit
	   autoload -U +X compinit && compinit \
		  && source $HOME/.afni/help/all_progs.COMP.zsh
	fi

	source $HOME/Programs/zsh-autosuggestions/zsh-autosuggestions.zsh
	source $HOME/Programs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	source $HOME/Programs/zsh-vim-mode/zsh-vim-mode.plugin.zsh && unbind_vicmd_keys
	
	# Freesurfer
	FREESURFER_HOME=/Applications/freesurfer/8.1.0/
	# Only duck with freesurfer if its home directory actually exists:
	if [ -d "$FREESURFER_HOME" ]; then
		export FREESURFER_HOME
		export FS_LICENSE=$FREESURFER_HOME/license.txt
		source $FREESURFER_HOME/SetUpFreeSurfer.sh
	fi
fi

# zsh-autosuggestion keybindings:
# Use Ctrl+l to accept the autosuggestion:
bindkey '^l' autosuggest-accept

