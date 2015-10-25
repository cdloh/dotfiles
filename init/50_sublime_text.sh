#Create the Installed Packages dir

mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages

#Install package manager so all of our packages are installed on startup
#Sublime Text will still need a restart on next boot

curl -o ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/Package\ Control.sublime-package https://packagecontrol.io/Package%20Control.sublime-package
