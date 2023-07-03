function install_tpope_bundle_plugin() {
  local name=$1
  bundle_dir=~/.vim/bundle
  mkdir -p $bundle_dir
  plugin_dir="${bundle_dir}/${name}"
  if [ ! -d $plugin_dir ]; then
    cd $bundle_dir
    git clone "https://github.com/tpope/${name}.git"
    vim -u NONE -c "helptags ${name}/doc" -c q
    cd -
  fi
}

function install_tpope_start_plugin() {
  local name=$1
  start_dir=~/.vim/pack/tpope/start
  mkdir -p $start_dir
  plugin_dir="${start_dir}/${name}"

  if [ ! -d $plugin_dir ]; then
    cd $start_dir
    git clone "https://tpope.io/vim/${name}.git"
    vim -u NONE -c "helptags ${name}/doc" -c q
    cd -
  fi
}

if [ $(vim --version | grep -c +clipboard) == 1 ]; then
  echo "vim already has +clipboard installed"
else
  echo "installing vim through brew"
  brew install vim
fi

if [ ! -f ~/.vim/autoload/pathogen.vim ]; then
  echo "Installing VIM pathogen plugin manager"
  mkdir -p ~/.vim/autoload ~/.vim/bundle
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

if [ ! -f ~/.vim/autoload/plug.vim ]; then
  echo "Installing VIM plug plugin manager"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install plugins

install_tpope_bundle_plugin 'vim-rails'
install_tpope_bundle_plugin 'vim-obsession'

install_tpope_start_plugin 'surround'
install_tpope_start_plugin 'abolish'

# Install ctrlp: https://github.com/ctrlpvim/ctrlp.vim
if [ ! -d ~/.vim/pack/plugins/start/ctrlp ]; then
  mkdir -p ~/.vim/pack/plugins/start
  git clone --depth=1 https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/pack/plugins/start/ctrlp
fi

echo "Finished setting up VIM"
