which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    # https://github.com/mxcl/homebrew/wiki/installation
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade

if ! brew ls --versions bundle > /dev/null; then
  brew tap Homebrew/bundle
fi

brew bundle

