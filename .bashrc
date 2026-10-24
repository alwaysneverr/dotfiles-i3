#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

fastfetch

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -la --color=auto'
alias update='sudo pacman -Syu'
alias clean='sudo pacman -Sc'
alias fetch='clear && fastfetch'
alias shutdown='sudo systemctl poweroff'
alias reboot='sudo systemctl reboot'
alias suspend='sudo systemctl suspend'
alias ..='cd ..'
alias ...='cd ../..'
alias config-i3='nano ~/.config/i3/config'
alias config-bar='nano ~/.config/i3status/config'
alias config-bash='nano ~/.bashrc'
alias config-kitty='nano ~/.config/kitty/kitty.conf'
alias mem='free -h'
alias jc='journalctl -p 3 -xb'
alias ping-test='ping -c 4 1.1.1.1'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias fastfetch='clear && fastfetch'

PS1='\[\033[38;2;236;197;135m\]\u\[\033[0m\]@\[\033[38;2;224;62;62m\]\h\[\033[0m\]:\[\033[38;2;238;222;200m\]\w\[\033[0m\]\$ '
