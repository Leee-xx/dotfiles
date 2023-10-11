# Download iterm2: https://iterm2.com/
# Then, open Iterm2, go to Preferences, click the Preferences tab, check the
# "Load preferences from a custom folder or URL", and navigate to
# com.googlecode.iterm2.plist
# Preferences > Profiles > Keys (https://mariusschulz.com/blog/keyboard-shortcuts-for-jumping-and-deleting-in-iterm2)
#   Left/Right option key: Esc+
#   > Key Mappings
#       Command | Action | Send
#     + Jump to start of word | Send Escape | b
#     + Jump to end of word | Send Escape | f
#     + Delete to start of word | Send Hex Codes | 0x17

github_email=$1

echo "*** Setting up local machine ***"

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
  brew install zsh
  # Install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  # May need to separately brew install fzf
  brew install fzf
  curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
  cp ./.zshrc ~/
  source ~/.zshrc
fi

bash ./setup/github.sh $github_email
bash ./setup/vim.sh
bash ./setup/ruby.sh

echo -e "\n* Finished setting up loacl machine"
