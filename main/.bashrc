#
# lumiscosity's ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

function aliaslist() {
    echo "$(tput bold)get$(tput sgr0) - pacman -Syu shorthand"
    echo "$(tput bold)linuxmoment$(tput sgr0) - for when you have a Linux Moment™"
    echo "$(tput bold)minnaterms$(tput sgr0) - the minna terms for today"
    echo "$(tput bold)modbash$(tput sgr0) - opens the .bashrc"
    echo "$(tput bold)modneofetch$(tput sgr0) - opens the neofetch config"
    echo "$(tput bold)rm2k3$(tput sgr0) - automatically sets up an rm2k3 dev environment"
    echo "$(tput bold)rm2k3moment$(tput sgr0) - for when you have an RPG Maker 2003 Moment™"
    echo "$(tput bold)ydl [URL] [format]$(tput sgr0) - youtube-dlp if it was good"
    echo "$(tput bold)yeet$(tput sgr0) - pacman -r shorthand"
}

alias get="sudo pacman -Syu"
alias linuxmoment="echo Linux Moment™ && play -q '/home/maple/Pictures/config/linuxmoment.mp3'"
alias modbash="nano ~/.bashrc && source ~/.bashrc"
alias modneofetch="nano ~/.config/neofetch/config.conf"
alias yeet="sudo pacman -R"
alias rm2k3moment="echo RPG Maker 2003 Moment™ && play -q '/home/maple/Pictures/config/linuxmoment.mp3'"

function minnaterms () {
    terms='ERROR'
    if [ $(date +%A) == 'Sunday' ] || [ $(date +%A) == 'Tuesday' ] || [ $(date +%A) == 'Friday' ]; then
        terms='masculine terms!'
    fi
    if [ $(date +%A) == 'Monday' ] || [ $(date +%A) == 'Thursday' ] || [ $(date +%A) == 'Saturday' ]; then
        terms='feminine terms!'
    fi
    if [ $(date +%A) == 'Wednesday' ]; then
        terms='ambiguous terms ONLY!'
    fi
    echo "Today is $(tput bold)$(date +%A)$(tput sgr0), which means Minnatsuki should be described with $(tput bold)$terms$(tput sgr0)"
}

function rm2k3() {
    gamepath='/run/media/maple/T7/games and tools/dev/CU_19JUN23'
    # wine doesn't like being piped to dev/null, so we run it in another window
    # as much as i'd prefer to run it in black box, idk the command for it
    kgx -e "wine '/home/maple/.local/share/Steam/steamapps/common/RPG Maker 2003/rpg2003.exe'" & disown
    clear
    while [ true ]; do
        read -p "Press ENTER to run EasyRPG, or ^C to exit: "
        easyrpg-player --test-play --window --project-path "$gamepath" --rtp-path '/home/maple/.local/share/Steam/steamapps/common/RPG Maker 2003/RTP'
    done
}

function ydl() {
    if [ $# != 2 ]; then
        echo "Invalid amount of arguments: $#"
        echo "Proper usage: ydl [URL] [format]"
        return
    fi
    if [ $2 = wav ] || [ $2 = mp3 ] || [ $2 = ogg ]; then
        formatprefix='-x --audio-format'
    fi
    if [ $2 = mp4 ] || [ $2 = webm ]; then
        formatprefix='--remux-video'
    fi
    yt-dlp $formatprefix $2 --embed-metadata $1

}

eval "$(rbenv init - bash)"

PS1="\[$(tput setaf 16)\]\[$(tput setab 204)\][\u@\h in \W]\[$(tput sgr0)\]\[$(tput setaf 204)\]◣\[$(tput sgr0)\] "
PS2="\[$(tput setaf 16)\]\[$(tput setab 204)\][>]\[$(tput setaf 5)\]\[$(tput sgr0)\] "