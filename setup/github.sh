echo -e "\n*** Setting up Github ***"

email=$1

function append_if() {
  local text=$1
  local file=$2
  if [ $(grep -cF $text $file) -lt 1 ]; then
    echo "Appending $text to $file"
    echo "$text" >> $file
  fi
}

echo "Enabling ssh-agent"
eval "$(ssh-agent -s)"

local identity_file=~/.ssh/id_ed25519
if [[ ! -z $email ]]; then
  echo "Setting git global email to ${email}"
  git config --global user.email $email

  if [ $(grep -c $email ~/.ssh/*.pub) -eq 0 ]; then
    today=$(date +'%Y%m%d')
    identity_file=~/.ssh/ed25519_$today
    echo "No SSH key found for ${email}, creating a new one and saving to ${identity_file}"
    ssh-keygen -t ed25519 -C "$email" -f "$identity_file" -q -N ""
  fi
fi

# SSH setup
github_doc_url='https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent'
touch ~/.ssh/config
if [ $(grep -c "Host github.com" ~/.ssh/config) -lt 1 ]; then
  echo "Updating ~/.ssh/config with github host details, see ${github_doc_url} for more"
  cat <<EOT >> ~/.ssh/config
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile $identity_file
EOT
fi

ignore_file=~/.gitignore
touch $ignore_file
git config --global core.excludesfile $ignore_file

append_if '**/.DS_Store' $ignore_file
append_if '**/*.vim' $ignore_file
append_if '**/[._]*.sw[a-p]' $ignore_file

git config --global init.defaultBranch main

echo "* Finished setting up Git/Github"
