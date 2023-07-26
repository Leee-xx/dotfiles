echo -e "\n*** Setting up Ruby ***"
# Install rbenv
if brew ls --versions rbenv > /dev/null; then
  echo "rbenv already installed"
else
  brew install rbenv ruby-build
  source ~/.zshrc
fi
echo "* Finished setting up Ruby"
