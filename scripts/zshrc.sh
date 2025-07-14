# ZSH History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY

BASEDIR="$(dirname "$(dirname "$0")")"

has() {
    command -v "$1" &> /dev/null
}

install-package() {
	if has apt; then
		sudo packman -Sy "$1"
	elif has zypper; then
		sudo zypper in "$1"
	elif has apt; then
		sudo apt install "$1"
	fi
}

# Bash-like shortcuts
bindkey '^[[1;5C' forward-word #Ctrl + Right
bindkey '^[[1;5D' backward-word #Ctrl + Left

modern-replace() {
    orig_cmd="$1"
    new_cmd="$2"
    orig_cmd_with_args="${3:-$1}"
    new_cmd_with_args="${4:-$2}"

    if command -v "$new_cmd" &> /dev/null; then
        alias "$orig_cmd=$new_cmd_with_args"
    else
        alias "$orig_cmd=$orig_cmd_with_args"
    fi
}

modern-replace 'ls' 'eza' 'ls -h --color=auto'
modern-replace 'car' 'bat'
modern-replace 'rm' 'trash-put'

#alias
alias ll='ls -l --color'
alias l='ll'
alias lla='ls -lA --color'
alias grep='grep --color'
# alias rm='rm -ir'
alias mkdirs='mkdir -p'

alias ip='ip -c -h -p'
alias ipa='ip -br a'
alias ipj='ip -j'
alias ipv4='curl https://1.0.0.1/cdn-cgi/trace -4 | grep ip'
alias ipv6="curl 'https://[2606:4700:4700::1111]/cdn-cgi/trace' -6 | grep ip"

alias findtxt='grep -IHrnws --exclude=\*.log -s '/' -e'
alias clr='reset'
alias please='sudo'

alias tar-create='tar -cvf'
alias tar-expand='tar -zxvf'
alias tar-look='tar -tf'

alias du='du -h'

alias tmuxs="tmux new-session -s"
alias tmuxr="tmux attach-session -t"
alias tmuxl="tmux list-sessions"

mkcd() {
    if [[ -z $1 ]]; then
        echo "Usage: mkcd <directory>"
        return 1
    fi

    mkdir -p "$1" && cd "$1" || return 1
}

alias sctl="sudo systemctl"
alias sctlu="systemctl --user"
alias jctl="sudo journalctl"
alias jctlu="journalctl --user-unit"

compress-7zst() {
    if [ -z "$1" ]; then
        echo "Usage: compress-7zst <out_file> <in_files...>"
        return
    fi
    7z a -m0=zstd -mx17 -mmt35 "$1" "$2"
}

#Set EDITOR
if has micro; then
    export EDITOR="micro"
elif has vim; then 
    export EDITOR="vim"
else
	install-package micro
	export EDITOR="micro"
fi

export PATH="$SCR/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export NIXPKGS_ALLOW_UNFREE=1

addline() {
  grep -qxF "$2" "$1" || echo "$2" >> "$1"
}

spushd () {
    pushd "$@" > /dev/null || exit
}
spopd () {
    popd "$@" > /dev/null || exit
}

# Minecraft coloring
color() {
    tmp="$*&r"
    tmp="${tmp//&0/\033[0;30m}"
    tmp="${tmp//&1/\033[0;34m}"
    tmp="${tmp//&2/\033[0;32m}"
    tmp="${tmp//&3/\033[0;36m}"
    tmp="${tmp//&4/\033[0;31m}"
    tmp="${tmp//&5/\033[0;35m}"
    tmp="${tmp//&6/\033[0;33m}"
    tmp="${tmp//&7/\033[0;37m}"
    tmp="${tmp//&8/\033[1;30m}"
    tmp="${tmp//&9/\033[1;34m}"
    tmp="${tmp//&a/\033[1;32m}"
    tmp="${tmp//&b/\033[1;36m}"
    tmp="${tmp//&c/\033[1;31m}"
    tmp="${tmp//&d/\033[1;35m}"
    tmp="${tmp//&e/\033[1;33m}"
    tmp="${tmp//&f/\033[1;37m}"
    tmp="${tmp//&r/\033[0m}"
    newline=$'\n'
    tmp="${tmp//&n/$newline}"
    echo "$tmp"
}
alias colors="color '&000&111&222&333&444&555&666&777&888&999&aaa&bbb&ccc&ddd&eee&fff'"

# Includes
for f in "$SCR/includes/"*.*sh; do source "$f"; done

# include if it exists
[ -f "$HOME/extra.rc.sh" ] && source "$HOME/extra.rc.sh"
