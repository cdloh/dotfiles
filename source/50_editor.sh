# Editing

if [[ ! "$SSH_TTY" ]] && is_osx; then
  export EDITOR='vim'
  export LESSEDIT='vim'
else
  export EDITOR='vim'
fi

export VISUAL="$EDITOR"
alias q="$EDITOR"
alias qv="q $DOTFILES/link/.{,g}vimrc +'cd $DOTFILES'"
alias qs="q $DOTFILES"
