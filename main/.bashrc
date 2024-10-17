#
# lumiscosity's ~/.bashrc
#

# Settings for existing commands

[[ $- != *i* ]] && return

export EDITOR=nano
export SUDO_PROMPT='[sudo] input password: '

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias neofetch='neowofetch'
alias sudo='sudo -B'

MAINCOL=204
BACKCOL=16

function aliaslist() {
    echo "$(tput bold)anymoment$(tput sgr0) - for when you have any Moment™"
    echo "$(tput bold)compall$(tput sgr0) - compress all pngs in the current directory"
    echo "$(tput bold)compone$(tput sgr0) - compress a png"
    echo "$(tput bold)get$(tput sgr0) - pacman -Syu shorthand"
    echo "$(tput bold)gtk4moment$(tput sgr0) - for when you have a GTK4 Moment™"
    echo "$(tput bold)linuxmoment$(tput sgr0) - for when you have a Linux Moment™"
    echo "$(tput bold)mcrt$(tput sgr0) - no-fuss single-command mconf reader"
    echo "$(tput bold)mitt$(tput sgr0) - no-fuss single-command git wrapper"
    echo "$(tput bold)modbash$(tput sgr0) - opens the .bashrc"
    echo "$(tput bold)modnf$(tput sgr0) - opens the neofetch config"
    echo "$(tput bold)pcache$(tput sgr0) - pacman -Sc shorthand"
    echo "$(tput bold)rebash$(tput sgr0) - refreshes the .bashrc"
    echo "$(tput bold)rm2k3$(tput sgr0) - automatically sets up an rm2k3 dev environment"
    echo "$(tput bold)rm2k3moment$(tput sgr0) - for when you have an RPG Maker 2003 Moment™"
    echo "$(tput bold)xiv$(tput sgr0) - turns on ffxiv with nvx"
    echo "$(tput bold)ydl [URL] [format]$(tput sgr0) - youtube-dlp if it was good"
    echo "$(tput bold)yeet$(tput sgr0) - pacman -Rs shorthand"
}

alias get="sudo pacman -Syu"
alias gtk4moment="anymoment GTK4"
alias linuxmoment="anymoment Linux"
alias pcache="yay -Sc"
alias rebash="source ~/.bashrc"
alias rm2k3moment="anymoment 'RPG Maker 2003'"
alias xiv="nvx start xivlauncher-core"
alias yeet="sudo pacman -Rs"

function anymoment() {
    if [ "$1" ]; then
        echo $1 Moment™
        play -q '/home/maple/Pictures/config/linuxmoment.mp3'
    fi
}

function rcomp() {
    find . -type f -exec advpng -z {} -4 \;
    find . -type f -exec oxipng -o max --zopfli -a -s {} \;
}

function compall() {
    for file in *; do
        if [ -f "$file" ]; then
            if [ "$1" == "--pics" ]; then
                oxipng -o max --zopfli --nb --nc --ng -a -s "$file"
            elif [ "$1" == "--hard" ]; then
                advpng -z "$file" -4
                oxipng -o max --zopfli -a -s "$file"
            else
                oxipng -o max --zopfli -a -s $@ "$file"
            fi
        fi
    done

}

function compone() {
    advpng -z "$1" -4
    oxipng -o max --zopfli -a -s "$1"
}

function mcommons() {
    # modify these variables to theme your mindless ecosystem programs!
    # note that bash variables will be evaluated.
    CATEGORY='# $1'
    SEPARATOR='-----'

    HELP_HEADER='$1 - $2'
    HELP_USAGE='usage: $1'
    HELP_BRACKETINFO_ROUND='(round brackets) - required'
    HELP_BRACKETINFO_SQUARE='[square brackets] - optional'
    HELP_USAGE='$1 - $2'

    ERROR_NOARG='no arguments provided!'
    ERROR_INVARG='invalid argument!'
    ERROR_INVSYNTAX='invalid syntax!'
    ERROR_CUSTOM_HEADER_PREFIX=''
    ERROR_CUSTOM_HEADER_SUFFIX=''

    ERROR_ONELINER='error: $1'
    ERROR_HINT='hint: $1'

    REGULAR_CUSTOM_PREFIX=''
    REGULAR_CUSTOM_SUFFIX=''

    if [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
        mcommons header 'mcommons' 'mindless ecosystem common messages' 'mcommons (command)'
        echo 'if you want to theme the mindless ecosystem programs,'
        echo 'modify this file!'
        mcommons help bracketinfo
        mcommons category 'generic'
        mcommons usage 'category' '(text)'
        mcommons usage 'separator'
        echo ''
        mcommons category 'help info'
        echo 'help header (name) (explanation) (usage)'
        echo 'help bracketinfo'
        echo 'qhelp (name) (explanation) (usage) - both commands above'
        echo 'usage (name) (args) [explanation]'
        echo ''
        echo '# error handling'
        echo 'error noarg (helpcommand) [hints]'
        echo 'error invarg (helpcommand) [hints]'
        echo 'error invsyntax (propercommand) [hints]'
        echo 'error custom (text)'
        echo 'error bcustom (title) (body) [hints]'
        echo 'error hint (text)'
    elif [ "$1" == "category" ]; then
        shift 1
        if [ "$1" ]; then
            echo $(eval echo $CATEGORY)
        else
            mcommons error invsyntax 'category (text)'
        fi
    elif [ "$1" == "separator" ]; then
        echo $(eval echo $SEPARATOR)
    elif [ "$1" ]; then
        echo "eeyikes!"
        #mcommons error invarg 'mcommons --help'
    else
        echo "eeyikes!"
        #mcommons error noarg 'mcommons --help'
    fi
}

function marg() {
    if [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
        echo 'marg - mindless argument parser'
        echo 'usage: marg (command) ($@)'
        echo '-----'
        echo '(round brackets) - required'
        echo '[square brackets] - optional'
        echo '-----'
        echo 'has (argument) ($@) - checks if argument is included'
        echo 'ahas (argument) (position) ($@) - has, but after a position'
        echo 'phas (argument) (position) ($@) - has, but for a specific position'
        echo ''
        echo 'dhas (argument) (errval) ($@) - prints the value after this argument'
        echo 'adhas (argument) (position) (errval) ($@) - ahas for dhas'
        echo 'pdhas (argument) (position) (errval) ($@) - phas for dhas'
    elif [ "$1" == "has" ]; then
        if [ "$2" ] && [ "$3" ]; then
            check=$2
            shift 2
            while [ $# > 0 ]; do
                if [ $1 == $check ]; then
                    return 1
                fi
                shift
            done
            return 0
        else
            echo 'invalid syntax!'
            echo 'has (argument) ($@) - checks if argument is included'
        fi
    elif [ "$1" == "ahas" ]; then
        if [ "$2" ] && [ "$3" ] && [ "$4" ]; then
            check=$2
            shift $(($3 + 3))
            marg has $check $@
        else
            echo 'invalid syntax!'
            echo 'ahas (argument) (position) ($@) - has, but after a position'
        fi
    elif [ "$1" == "phas" ]; then
        if [ "$2" ] && [ "$3" ] && [ "$4" ]; then
            check=$2
            shift $(($3 + 3))
            if [ $1 == $check ]; then
                return 1
            else
                return 0
            fi
        else
            echo 'invalid syntax!'
            echo 'phas (argument) (position) ($@) - has, but for a specific position'
        fi
    elif [ "$1" == "dhas" ]; then
        echo 'heehee'
    fi
}

function mcrt() {
    # note for developers; mcrt files use the .mcf extension!
    if [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
        echo 'mcrt - mindless config reading tool'
        echo 'usage: mcrt (command)'
        echo '-----'
        echo '(round brackets) - required'
        echo '[square brackets] - optional'
        echo '-----'
        echo 'del (path) (key) - deletes a key'
        echo 'get (path) (key) [--no-defaults] - echoes the value for the key'
        echo 'set (path) (key) (value) [--no-overwrite] - sets the value for the given key'
    elif [ "$1" == "del" ]; then
        if [ "$2" ] && [ "$3" ]; then
            if [ -f $2 ]; then
                sed -i /$3/d $2
                return 0
            else
                echo "file $2 doesn't exist!"
                return 1
            fi
        else
            echo 'invalid syntax! proper usage:'
            echo 'del (path) (key) - deletes a key'
        fi
    elif [ "$1" == "get" ]; then
        if [ "$2" ] && [ "$3" ]; then
            if [ ! -f $2 ]; then
                echo "error: file $2 doesn't exist!"
                return 1
            fi
            while IFS="" read -r p || [ -n "$p" ]; do
                line=$(printf '%s\n' "$p")
                if [[ $line:0:1 == '#' ]]; then
                    continue
                fi
                if [[ $line =~ $3= ]]; then
                    echo "${line#*=}"
                    return 0
                fi
            done < $2
            if [ "$4" == '--no-defaults' ]; then
                echo "error: key $3 not found!"
                return 1
            else
                echo '0'
                return 0
            fi
        else
            echo 'invalid syntax! proper usage:'
            echo 'get (path) (key) [--zero-on-failure]'
        fi
    elif [ "$1" == "set" ]; then
        if [ "$2" ] && [ "$3" ] && [ "$4" ]; then
            if [ ! -f $2 ]; then
                echo "file $2 doesn't exist!"
                return 1
            fi
            if [ "$5" == '--no-overwrite' ] && [ $(mcrt get $2 $3 > /dev/null) ]; then
                echo "error: key $3 already exists in file $2!"
                return 1
            fi
            sed -i /$3/d $2
            echo "$3=$4" >> $2
            return 0
        else
            echo 'invalid syntax! proper usage:'
            echo 'set (path) (key) (value) [--no-overwrite]'
        fi
    elif [ "$1" ]; then
        echo 'invalid command!'
        echo 'try `mcrt help` to see available commands.'
    else
        echo 'no arguments provided!'
        echo 'try `mcrt help` to see available commands.'
    fi
}

function mitt() {
    # pregen config
    export MITT_CONFIG_PATH="$HOME/.config/mitt.mcf"
    if [ ! -f $MITT_CONFIG_PATH ]; then
        touch $MITT_CONFIG_PATH
        mcrt set $MITT_CONFIG_PATH default_forge_url https://github.com/
    fi

    # actual program starts here
    if [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
        echo 'mitt - mindless information transposing tool'
        echo 'usage: mitt (command)'
        echo '-----'
        echo '(round brackets) - required'
        echo '[square brackets] - optional'
        echo '[--] - more flags available, see command help'
        echo '-----'
        echo 'amend - amend the latest commit'
        echo 'branch [--] - handles branch operations; see branch help'
        echo 'clone (url) [--no-submodules] - clones a project'
        echo 'config [--] - sets various configuration data; see config help'
        echo 'init [path] - initializes a repo (defaults to the current folder)'
        echo 'push [--writemessage/-w]/[message] - pushes all current changes'
        echo 'pull [-f] - pulls every change from the source'
        echo 'reset [n commits back] - resets to a commit, defaults to HEAD'
        echo 'squash (n commits) [message] - squashes commits'
        echo 'help - shows this message'
    elif [ "$1" == "branch" ]; then
        git commit --amend
    elif [ "$1" == "branch" ]; then
        if [ "$2" == "help" ]; then
            echo 'mitt branch'
            echo '-----'
            echo '(round brackets) - required'
            echo '[square brackets] - optional'
            echo '-----'
            echo 'delete (name) [--withremote] - removes a branch'
            echo 'list [-r/-a/wildcard] - lists branches'
            echo 'new (name) [--no-switch]'
            echo 'switch (name) - switches to a branch'
        elif [ "$2" == "delete" ]; then
            if [ "$3" ]; then
                answer=""
                read -p "are you sure? y/N: " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
                git branch -D $3
                if [ "$4" == "--withremote" ]; then
                    git push origin -d $3
                    git fetch origin -p
                fi
            else
                echo 'invalid syntax!'
                echo 'branch delete (name) [--withremote] - removes a branch'
            fi
        elif [ "$2" == "list" ]; then
            git branch --list $3
        elif [ "$2" == "new" ]; then
            if [ "$3" ]; then
                git branch $3
                if [ "$4" != "--no-switch" ]; then
                    git switch $3
                fi
            else
                echo 'invalid syntax!'
                echo 'branch new (name) [--no-switch]'
            fi
        elif [ "$2" == "switch" ]; then
            git switch $3
        elif [ "$2" ]; then
            echo 'invalid syntax!'
            echo 'try `mitt branch help` to see available commands.'
        else
            echo 'no arguments provided!'
            echo 'try `mitt branch help` to see available commands.'
        fi
    elif [ "$1" == "clone" ]; then
        if [ "$2" ]; then
            if [[ "$2" =~ ^[^\/]*\/[^\/]*$ ]]; then
                DEFAULT_FORGE_URL=$(mcrt get $MITT_CONFIG_PATH default_forge_url)
                echo "user/project slug detected; defaulting to $DEFAULT_FORGE_URL"
                git clone "$DEFAULT_FORGE_URL$2"
            else
                git clone "$2"
            fi
            cd "${2##*/}"
            skip_submodules=$?
            if [ "$3" != "--no-submodules" ] && [ $skip_submodules == 0 ]; then
                git submodule update --init
            fi
        else
            echo 'invalid syntax! proper usage:'
            echo 'clone (url) [--no-submodules]'
            echo 'hint: (url) takes a github-like slug'
        fi
    elif [ "$1" == "config" ]; then
        if [ "$2" == "help" ]; then
            echo 'mitt config'
            echo '-----'
            echo '(round brackets) - required'
            echo '[square brackets] - optional'
            echo '-----'
            echo 'list - lists available config options'
            echo 'reset (option) - resets an option'
            echo 'set (option) (value) - sets an option'
        elif [ "$2" == "list" ]; then
            echo 'default_code_forge - the code forge to default to'
            echo '                     when running mitt clone with'
            echo '                     only a slug'
        # TODO: make these check if the config is valid
        elif [ "$2" == "reset" ]; then
            mcrt del $MITT_CONFIG_PATH $3
        elif [ "$2" == "set" ]; then
            mcrt set $MITT_CONFIG_PATH $3 $4
        elif [ "$2" ]; then
            echo 'invalid syntax!'
            echo 'try `mitt config help` to see available commands.'
        else
            echo 'no arguments provided!'
            echo 'try `mitt config help` to see available commands.'
        fi
    elif [ "$1" == "init" ]; then
        if [ "$2" ]; then
            git init $2
        else
            git init
        fi
    elif [ "$1" == "push" ]; then
        git add -A
        if [ "$2" == "--writemessage" ] || [ "$2" == "-w" ]; then
            git commit
        elif [ "$2" ]; then
            git commit -m "$2"
        else
            git commit -m "-"
        fi
        git push
    elif [ "$1" == "pull" ]; then
        if [ "$2" == "-f" ]; then
            git add -A
            git stash
        fi
        git pull -f
        if [ "$2" == "-f" ]; then
            git stash pop
        fi
    elif [ "$1" == "reset" ]; then
        if [ "$2" ]; then
            git reset HEAD~$2
        else
            git reset --hard
        fi
    elif [ "$1" == "squash" ]; then
        if [ "$2" ]; then
            if [ "$3" ]; then
                git reset --soft HEAD~$2 && git commit -m "$3" && git push --force
            else
                git reset --soft HEAD~$2 && git commit -m "-" && git push --force
            fi
        else
            echo 'invalid syntax! proper usage:'
            echo 'squash (n commits) [message]'
        fi
    elif [ "$1" ]; then
        echo 'invalid command!'
        echo 'try `mitt help` to see available commands.'
    else
        echo 'no arguments provided!'
        echo 'try `mitt help` to see available commands.'
    fi
}

function modbash() {
    if [ $# == 1 ]; then
        $1 ~/.bashrc && source ~/.bashrc
    else
        $EDITOR ~/.bashrc && source ~/.bashrc
    fi
}

function modnf() {
    if [ $# == 1 ]; then
        $1 ~/.config/neofetch/config.conf
    else
        $EDITOR ~/.config/neofetch/config.conf
    fi
}


function rm2k3() {
    wine '/home/maple/.local/share/Steam/steamapps/common/RPG Maker 2003/rpg2003.exe'
}

function ydl() {
    if [ $# != 2 ]; then
        echo "Invalid amount of arguments: $#"
        echo "Proper usage: ydl [URL] [format]"
        return
    fi
    if [ $2 = wav ] || [ $2 = mp3 ] || [ $2 = ogg ] || [ $2 = opus ] || [ $2 = flac ]; then
        formatprefix='-x --audio-format'
    fi
    if [ $2 = mp4 ] || [ $2 = webm ] || [ $2 = mkv ]; then
        formatprefix='--remux-video'
    fi
    yt-dlp $formatprefix $2 --embed-metadata $1 $@

}

PS1="\[$(tput setaf $BACKCOL)\]\[$(tput setab $MAINCOL)\][\u@\h in \W]\[$(tput sgr0)\]\[$(tput setaf $MAINCOL)\]◣\[$(tput sgr0)\] "
PS2="\[$(tput setaf $BACKCOL)\]\[$(tput setab $MAINCOL)\][>]\[$(tput setaf 5)\]\[$(tput sgr0)\] "
SIGNOFF='Signed-off-by: lumiscosity <averyrudelphe@gmail.com>'
