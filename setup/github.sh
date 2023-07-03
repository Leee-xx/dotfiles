echo "Setting up Github"

email=$1

eval "$(ssh-agent -s)"

function append_if() {
  local text=$1
  local file=$2
  if [ $(grep -cF $text $file) -lt 1 ]; then
    echo "Appending $text to $file"
    echo "$text" >> $file
  fi
}

# SSH setup
if [ $(grep -c $email ~/.ssh/*.pub) -eq 0 ]; then
  today=$(date +'%Y%m%d')
  key_file_basename=~/.ssh/ed25519_$today
  echo "Generating new SSH key for ${email}, saving to ${key_file_basename}"
  ssh-keygen -t ed25519 -C "$email" -f $key_file_basename -q -N ""
fi

github_doc_url='https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent'
touch ~/.ssh/config
if [ $(grep -c "Host github.com" ~/.ssh/config) -lt 1 ]; then
  echo "Updating ~/.ssh/config github, see ${github_doc_url} for more"
  cat <<EOT >> ~/.ssh/config
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOT
fi

ignore_file=~/.gitignore
touch $ignore_file
git config --global core.excludesfile $ignore_file

append_if '**/.DS_Store' $ignore_file
append_if '**/*.vim' $ignore_file
append_if '**/[._]*.sw[a-p]' $ignore_file

git config --global init.defaultBranch main
