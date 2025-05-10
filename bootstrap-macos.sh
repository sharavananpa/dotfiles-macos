#!/usr/bin/env bash

set -e

echo "Setting things up in $(uname -s)..."

# Set up the dotfiles repository
DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Cloning the repository since it's missing..."
    git clone https://github.com/sharavananpa/dotfiles.git "$DOTFILES_DIR"
else
    echo "Repository already exists!"
fi

echo "Changing directory to $DOTFILES_DIR"
cd $DOTFILES_DIR

echo "Pulling latest changes"
git pull --rebase --autostash

# Set up Homebrew
if command -v brew >/dev/null 2>&1; then
    echo "Homebrew is already installed!"
else
    echo "Installing Homebrew to help manage packages..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# echo "Installing brew packages..."
# brew bundle --file ./brew/Brewfile

# Set up config files
echo "Removing stupid .DS_Store files (just in case)..."
find . -name ".DS_Store" -exec rm -f {} \;

echo "Creating symlinks for config files..."
stow brew git nvim zsh

# Set up mac settings using defaults write
read -p "Run defaults command to change mac settings?" changeSettings

case ${changeSettings,,} in
    y | yes)
        echo "Changing settings..."
        # Dock
        defaults write com.apple.dock "tilesize" -int "48"
        defaults write com.apple.dock "show-recents" -bool "false"

        defaults write com.apple.dock wvous-bl-corner -int 0
        defaults write com.apple.dock wvous-bl-modifier -int 0

        defaults write com.apple.dock wvous-br-corner -int 0
        defaults write com.apple.dock wvous-br-modifier -int 0

        defaults write com.apple.dock wvous-tl-corner -int 0
        defaults write com.apple.dock wvous-tl-modifier -int 0

        defaults write com.apple.dock wvous-tr-corner -int 0
        defaults write com.apple.dock wvous-tr-modifier -int 0

        killall Dock

        # Safari
        defaults write com.apple.Safari "ShowFullURLInSmartSearchField" -bool "true"
        defaults write com.apple.Safari HomePage -string "https://sharavananpa.dev"
        defaults write com.apple.Safari ShowStatusBar -bool "true"

        killall Safari

        # Finder
        defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

        defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
        defaults write com.apple.finder "ShowPathbar" -bool "true"
        defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"
        defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

        killall Finder

        # Keyboard
        defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool "false"
        defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool "false"
        defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool "false"

        # TextEdit
        defaults write com.apple.TextEdit "RichText" -bool "false" && killall TextEdit
        ;;
    *)
        echo "Not changing settings!"
        ;;
esac