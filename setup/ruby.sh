# Install rbenv
if brew ls --versions rbenv > /dev/null; then
  echo "rbenv already installed"
else
  brew install rbenv ruby-build
fi
