# OSX-only stuff. Abort if not OSX.
is_osx || return 1

#Create the Installed Packages dir
e_header "Creating the Installled packages dir"
mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages

#Create the Packages dir for linking the user data
e_header "Creating the Packages dir for linking user data"
mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages

e_header "Linking the user directory"
ln -sf "$DOTFILES/conf/sublime" ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

#Install package manager so all of our packages are installed on startup
#Sublime Text will still need a restart on next boot
e_header "Installing Package Control"
curl -o ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/Package\ Control.sublime-package "https://packagecontrol.io/Package%20Control.sublime-package"
