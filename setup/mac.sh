github_email=$1
# Download iterm2: https://iterm2.com/

# Install brew
if [ -x "$(command -v brew)" ]; then
  echo "Brew already installed"
else
  echo "Downloading Brew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install zsh and oh-my-zsh
if [ -x "$(command -v zsh)" ]; then
  echo "zsh already installed"
else
  echo "Installing zsh and zsh packages"
  brew install zsh zsh-completions
  # Install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  # May need to separately brew install fzf
fi

bash setup/github.sh $github_email
