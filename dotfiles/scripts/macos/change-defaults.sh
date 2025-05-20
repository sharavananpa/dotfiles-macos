#!/usr/bin/env bash

# Dock
defaults write com.apple.dock orientation -string "left"

defaults write com.apple.dock tilesize -int 48

defaults write com.apple.dock show-recents -bool false

defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0.1
defaults write com.apple.dock autohide-delay -float 0

defaults write com.apple.dock mineffect -string "scale"

killall Dock 2>/dev/null || true

# Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder _FXSortFoldersFirst -bool true

defaults write com.apple.finder DisableAllAnimations -bool true

defaults write com.apple.finder NewWindowTarget -string "PfHm"

killall Finder 2>/dev/null || true

# Keyboard and Mouse
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable .DS_Store crap
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Misc
defaults write com.apple.TextEdit RichText -bool false && killall TextEdit 2>/dev/null || true

defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

defaults write NSGlobalDomain AppleICUForce24HourTime -bool true

killall SystemUIServer 2>/dev/null || true