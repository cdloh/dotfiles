# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew recipes need Homebrew to install." && return 1

#Tapping kegs
kegs=(
  homebrew/services
  homebrew/completions
)

brew_tap_kegs

# Homebrew recipes
recipes=(
  git
  git-extras
  htop-osx
  tree
  wget
  httpie
  ipcalc
  jq
  imapfilter
  polipo
  pwgen
  vagrant-completion
)

brew_install_recipes

# Misc cleanup!

services=(
  polipo
)

brew_install_services