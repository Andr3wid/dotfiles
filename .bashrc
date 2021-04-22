# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
EDITOR=vim

# add cargo directory to path
PATH=$PATH:$HOME/.cargo/bin:$HOME/Android/Sdk

# set android sdk root
ANDROID_SDK_ROOT="$HOME/Android/Sdk"

export PATH
export EDITOR
export ANDROID_SDK_ROOT

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# cli tool aliases
alias vim="nvim"
alias ls="exa -l"
alias gs="git status"
alias ga="git add"
alias gc="git commit -S -m"
alias gp="git push"
alias top="btm --battery"
alias music="ncmpcpp --config=/home/andrew/.config/ncmpcpp/config"
alias ytdl="cd ~/Music && youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail"
alias airplay="/opt/rpiplay -n ricebowl"
alias ted="trans en:de"
alias tde="trans de:en"
alias dock="xrandr --output DisplayPort-2 --right-of eDP --mode 1920x1080 --primary && sudo systemctl stop tlp"
alias mobile="xrandr --output DisplayPort-3 --off && sudo systemctl start tlp && xrandr --auto"
alias sysup="sudo zypper up && sudo zypper dup --no-allow-vendor-change && sudo zypper verify"
alias gdx-setup="java -jar /opt/gdx-setup_latest.jar"

# directory & file aliases
alias wmconf="vim ~/.config/sway/config"
alias dotdir="cd ~/github/personal/dotfiles"
alias gdrive="cd ~/gdrive"

# set vi mode in terminal
set -o vi

# enable starship
eval "$(starship init bash)"

# enable zoxide
eval "$(zoxide init bash --cmd y)"
