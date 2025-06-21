prefix="&7[&3zshrc&7]"

# Sync config
check-config()
{
    file=$1
    sync=$2

    if ! [[ -L "$file" ]]
    then
        set -e
        color "$prefix &c$file is not a symlink, creating symlink"
        if [[ -f "$file" ]] || [[ -d "$file" ]]
        then
            echo "> Original file $file exists."
            echo "> Diff:"
            diff $file $sync
            bak="$file.bak"
            echo "> Moving $file to $bak..."
            mv $file $bak
        fi
        echo "> Creating symlink from $sync to $file..."
        mkdir -p "$(dirname "$file")"
        ln -sf "$sync" "$file"
        color "$prefix &aDone!"
        set +e
    fi
}

# Sync inject
check-inject()
{
    file=$1
    config=$2
    
    if ! grep -Fxq "$config" "$file"; then
        echo "$config" >> "$file"
        color "$prefix &aLines injected for $file"
    fi
}

CFGSYNC="$SCR/../config-sync"

check-config "$HOME/.config/micro" "$CFGSYNC/.config/micro"
check-config "$HOME/.config/vim" "$CFGSYNC/.config/vim"
check-config "$HOME/.config/tmux" "$CFGSYNC/.config/tmux"
check-config "$HOME/.config/nvim" "$CFGSYNC/.config/nvim"

check-config "$HOME/.gitconfig" "$CFGSYNC/.gitconfig"
