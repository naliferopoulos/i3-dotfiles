# Should be in: ~/.zshrc

# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/infidel/.oh-my-zsh"

export TERM="xterm-256color"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# PowerLevel9K Settings
# Only display the current directory in the left part of the prompt.
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs) 

# Swap theme to something visible in TTYs that have no powerline support.
if [[ "$TERM" != 'xterm-256color' ]]; then
    ZSH_THEME='bira'
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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

# Custom bgnotify timer
bgnotify_threshold=1

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  command-not-found
  bgnotify
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Apply Wal theming 
cat ~/.cache/wal/sequences

# Support for Wal theming in TTYs
source ~/.cache/wal/colors-tty.sh

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Fix scrolling 
stty -ixon

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Aliases for editting ZSH Configuration
alias zshconfig="vim ~/.zshrc"
alias reload="source ~/.zshrc"

# Aliases for APT
alias upd="sudo apt update"
alias upg="sudo apt upgrade"
alias arm="sudo apt autoremove"

# Aliases for directory hopping
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"

# Aliases for colorls
alias l="colorls -l"
alias ll="colorls -lA"
alias dirs="colorls -d"
alias files="colorls -f"
alias tree="colorls -t"

# Alias for grep with color highlighting
alias grep="grep --color"

# Alias for vim to run neovim
alias vim="nvim"

# Aliases for easy grepping
alias -g G="| grep"
alias -g N="| grep -v"

# Aliases for easy head/tail/more/less
alias -g H="| head"
alias -g T="| tail"

alias -g M="| more"
alias -g L="| less"

# Alias for silencing stderr
alias -g S=" 2>/dev/null"

# Alias for notification daemon pop-up
alias -g notify="; notify-send \"Done\" \"Task is done!\""

# Serve the current directory over HTTP
# Usage: serve [port]
# Port is optional, if not specified default is used (TCP/8000)
serve () {
	if [ $# -eq 0 ]; then
		python -m SimpleHTTPServer
	else
		sudo python -m SimpleHTTPServer $1
	fi
}

# Switch to external monitor
extmon (){
	xrandr --output eDP-1 --off
	xrandr --output HDMI-1 --auto 
}

# Switch to internal monitor
intmon (){
	xrandr --output eDP-1 --auto
	xrandr --output HDMI-1 --off
}

# Show a clock on the terminal
showTime() {
	while sleep 1; do tput sc; tput cup 0 $(($(tput cols)-29));date;tput rc;done &
}

# Terminal screensaver based on hex. For caffeine lovers.
screensaverhex() {
	 clear; cat /dev/urandom | hexdump -C | grep "ca fe"; clear 
}

# Terminal screensaver based on fake installation process. Lists installed packages.
screensaver() {
	j=0;while true; do let j=$j+1; for i in $(seq 0 10 100); do echo $i;sleep 1; done | dialog --gauge "Installing package $j : $(apt list --installed 2> /dev/null | shuf -n 1 | cut -d ' ' -f 1,2,3)" 6 130;done

}

# Share the terminal session over port 5000. 
# Connect with netcat.
screenshare() {
	script -qf | tee >(nc -klp 5000)
}

# Continuously refresh the screen while executing a command.
refresh() {
	while true; do $@; sleep 1; clear; done;
}

# Prints welcome message using slow typing.
welcome() {
	echo "Welcome back! The time is $(date). Happy hacking! :)" | pv -qL 15
}

# Fetches an excuse for your boss based on the Bastard Operator From Hell database.
excuse() {
	telnet towel.blinkenlights.nl 666 | sed "s/=== The BOFH Excuse Server ===//" | tr -d '\n' && echo
}

# Turns keyboard LEDs on.
kbdon() {
	xset led on
}

# Highlights every third line of the output of a command for readability.
# Usage: command | highlight
highlight() {
	 awk '{if (NR%3==0){print "\033[32m" $0 "\033[0m"} else{print}}'; 
}
