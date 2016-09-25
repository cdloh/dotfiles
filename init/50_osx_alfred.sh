# Don't do anything if not OS X
is_osx || return 1

# Set the config folder
defaults write com.runningwithcrayons.Alfred-Preferences syncfolder "$DOTFILES"/conf/alfred/
