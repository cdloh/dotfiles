# Don't do anything if not OS X
is_osx || return 1

# Sets the config directory for iTerm
defaults write com.googlecode.iterm2 PrefsCustomFolder "$DOTFILES"/conf/iterm/
