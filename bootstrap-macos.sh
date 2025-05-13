#!/usr/bin/env bash

# set -e

log() {
    local color_code="\033[0;34m"
    local reset="\033[0m"

    # Add color based on severity
    if [[ "$1" == "error" ]]; then
        color_code="\033[0;31m"
    elif [[ "$1" == "warn" ]]; then
        color_code="\033[0;33m"
    elif [[ "$1" == "success" ]]; then
        color_code="\033[0;32m"
    fi

    # Print the log message with color
    printf "${color_code}[$(echo "$1" | tr '[:lower:]' '[:upper:]')] %s${reset}\n" "${*:2}"
}

log info "OS implementation: $(uname -s)"

log info "Trying to set up the dotfiles repository"

# Set up the dotfiles repository
DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
    log info "Cloning the repository since it's missing..."
    git clone https://github.com/sharavananpa/dotfiles.git "$DOTFILES_DIR"
else
    log warn "Repository already exists!"
fi

printf "\n"

# Change directory to dotfiles repository
log info "Changing directory to " "$DOTFILES_DIR"
cd $DOTFILES_DIR

printf "\n"

# Set up Homebrew
log info "Pulling latest changes and installing packages..."
git pull --rebase --autostash

if command -v brew >/dev/null 2>&1; then
    log warn "Homebrew is already installed!"
else
    log info "Installing homebrew to help manage packages..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

log info "Installing brew packages..."
brew bundle --file ./brew/Brewfile

printf "\n"

# Set up config files
log warn "Removing stupid .DS_Store files (just in case)..."
find . -name ".DS_Store" -exec rm -f {} \;

printf "\n"

log info "Creating symlinks for config files..."
mkdir -p ~/.config
stow brew git nvim zsh

# Set up mac settings using defaults write
read -p "Run defaults command to change mac settings? (y/N) " changeSettings

case $(echo "$changeSettings" | tr '[:upper:]' '[:lower:]') in
    y | yes)
        log info "Changing settings..."
        ./scripts/macos/change-defaults.sh
        ;;
    *)
        log warn "Not changing settings!"
        ;;
esac

printf "\n*****\n\n"
printf "You still might want to change the following settings manually...\n"
printf "1. Disable AI\n"
printf "2. Add/Remove login items\n"
printf "3. Finder preferences\n"
printf "4. Change lock screen settings\n"
printf "5. Set up Google account for mail\n"
printf "6. Change wallpaper\n"
printf "7. Tweak Dock preferences\n"
printf "8. Configure iCloud\n"
printf "9. Set up Safari\n"
printf "\n*****\n"
