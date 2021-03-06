# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew casks need Homebrew to install." && return 1

# Hack to show the first-run brew-cask password prompt immediately.
brew cask info this-is-somewhat-annoying 2>/dev/null

# Tapping some kegs
kegs=(
  caskroom/cask-versions
)

brew_tap_kegs

# Homebrew casks
casks=(
  # Applications
  alfred
  bettertouchtool
  caffeine
  firefox
  google-chrome
  google-chrome-canary
  iterm2
  karabiner
  macvim
  seil
  sourcetree
  sublime-text
  vagrant
  virtualbox
  vlc
  gpgtools
  spotify
)

# Install Homebrew casks.
casks=($(setdiff "${casks[*]}" "$(brew cask list 2>/dev/null)"))
if (( ${#casks[@]} > 0 )); then
  e_header "Installing Homebrew casks: ${casks[*]}"
  for cask in "${casks[@]}"; do
    brew cask install $cask
  done
  brew cask cleanup
fi

