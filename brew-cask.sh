#!/bin/bash


# to maintain cask ....
#     brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup`

# Install native apps

# daily
brew cask install --appdir="$HOME/Applications" spectacle

# dev
brew cask install --appdir="$HOME/Applications" iterm2
brew cask install --appdir="$HOME/Applications" visual-studio-code-insiders 

# Fonts
brew tap homebrew/cask-fonts 
brew cask install --appdir="$HOME/Applications" font-fira-code
brew cask install --appdir="$HOME/Applications" font-menlo-for-powerline

# Install at the global level
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" firefox
