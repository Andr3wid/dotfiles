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

export PATH
export EDITOR

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

# directory & file aliases
alias i3conf="vim ~/.config/i3/config"
alias dotdir="cd ~/github/personal/dotfiles"
alias gdrive="cd ~/gdrive"
alias uni="cd ~/gdrive/Uni/7.\ Semester\ -\ W20"



# set vi mode in terminal
set -o vi

# enable starship
eval "$(starship init bash)"
