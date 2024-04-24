# ----------------
# ferrisbox bashrc
# ----------------

[[ "$-" != *i* ]] && return

echo "$(tput setaf 8)-----$(tput sgr0)"
echo "$(tput bold)$(tput setaf 5)Welcome to Ferrisbox!$(tput sgr0)"
echo "Run $(tput bold)aliaslist$(tput sgr0) for a list of custom commands."
echo "$(tput setaf 8)-----$(tput sgr0)"

PS1="\[$(tput setaf 5)\]\[$(tput bold)\][\W|maple@ferrisbox]\[$(tput sgr0)\] "
PS2="\[$(tput setaf 5)\][>]\[$(tput sgr0)\] "

MSYSSOURCE="c:\\ProgramData\\msys2"
EDITOR="nano"

alias ls="ls -A -p"

alias modbash="nano ~/.bashrc && source ~/.bashrc"
alias modnano="nano ~/.nanorc"
alias modnf="nano $HOME/.config/neofetch/config.conf"

inexp() {
    if [[ ! -d "$1" ]] && [[ "$1" ]]; then
        >&2 echo "The folder could not be found!"
        break
    fi

    if [[ ${1::1} = '/' ]]; then
        explorer "$MSYSSOURCE${PWD//\//\\}${1//\//\\}"
    else
        explorer "$MSYSSOURCE${PWD//\//\\}\\${1//\//\\}"
    fi
}

yeet() {
    pacman -Rs "mingw-w64-x86_64-$1"
}

get() {
    if [[ "$1" ]]; then
        pacman -Syu "mingw-w64-x86_64-$1"
    else
        pacman -Syu
    fi
}

run() {
  cargo run --manifest-path "./$1/Cargo.toml" "$2"
}

test() {
  cargo test --manifest-path "./$1/Cargo.toml" --doc "$2"
}

aliaslist() {
    echo "$(tput bold)get$(tput sgr0) - download a package"
    echo "$(tput bold)inexp$(tput sgr0) - open a folder in explorer"
    echo "$(tput bold)modbash$(tput sgr0) - edit the .bashrc"
    echo "$(tput bold)modnano$(tput sgr0) - edit the nano config"
    echo "$(tput bold)modnf$(tput sgr0) - edit the neofetch config"
    echo "$(tput bold)run$(tput sgr0) - cargo run alias that takes a folder location"
    echo "$(tput bold)test$(tput sgr0) - cargo test --doc alias that takes a folder location"
    echo "$(tput bold)yeet$(tput sgr0) - remove a package"
}
