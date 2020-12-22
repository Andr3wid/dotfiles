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
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# cli tool aliases
alias vim="nvim"
alias ls="exa -l"
alias top="btm --battery"
alias music="ncmpcpp --config=/home/andrew/.config/ncmpcpp/config"
alias ytdl="cd ~/Music && youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail"
alias airsrv="/opt/rpiplay -n ricebowl"
alias ted="trans en:de"
alias tde="trans de:en"
alias omnet-docker="x11docker -i -- --rm -v '$(pwd):/root/models' -- omnetpp/omnetpp-gui:u18.04-5.6.2"
alias powercon="awk '{print $1*10^-6 \" W\"}' /sys/class/power_supply/BAT0/power_now"
alias i3conf="vim ~/.config/i3/config"



# set vi mode in terminal
set -o vi

# enable starship
eval "$(starship init bash)"

# set pywal set theme
cat ~/.cache/wal/sequences
