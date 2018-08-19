#!/bin/bash


# to maintain cask ....
#     brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup`


# Install native apps

# daily
brew cask install spectacle

# dev
brew cask install iterm2
brew cask install visual-studio-code-insiders 

# less often
brew cask install disk-inventory-x
brew cask install vlc

# Fonts
brew tap homebrew/cask-fonts 
brew cask install font-fira-code
brew cask install font-menlo-for-powerline


# Install at the global level
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" firefox