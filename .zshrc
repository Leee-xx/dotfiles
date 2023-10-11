stty -ixon

unsetopt nomatch

alias vim="/usr/local/bin/vim"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/leewang/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

HISTCONTROL=ignoreboth
setopt HIST_FIND_NO_DUPS
setopt HIST_NO_STORE

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  fzf
)

source $ZSH/oh-my-zsh.sh
export FZF_BASE=$(which fzf)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias gco="git checkout"
alias gs='git status'
alias gc='git commit'
alias grs='git_reset_soft'
alias grhd='git reset --hard'
alias gcp='git cherry-pick'
alias gp='git pull'
alias gg='git grep'
alias gps='git push'
alias gcb='git rev-parse --abbrev-ref HEAD'
alias gpsu='git push -u origin $(gcb)'
alias gl='git log'
alias gsh='git show'
alias gm='git merge'
alias gt='git tag'
alias gf='git fetch'
alias gus='git restore --staged'

gcurr_branch() {
  git rev-parse --abbrev-ref HEAD
}

function git_reset_soft() {
  local num_commits=1
  if [ ! -z $1 ]
  then
    num_commits=$1
  fi
  git reset --soft HEAD~$num_commits
}

function git_commits_since() {
  local commit=$1
  gl $commit.. --pretty=oneline | wc -l
}


# Merges base branch into current branch
gu() {
  local curr_branch=$(gcurr_branch)
  local base_branch="master"
  if [ ! -z $1 ]
  then
    base_branch=$1
  fi
  echo "\nUpdating $curr_branch with $base_branch"
  gco $base_branch && gp && gco $curr_branch && gm $base_branch

  # If previous command resulted in an error, go back to the initial branch
  if [ $? != 0 ]
  then
    gco $curr_branch
  fi
}

# Rebases base branch onto current branch
gurb() {
  local curr_branch=$(gcurr_branch)
  local base_branch="master"
  if [ ! -z $1 ]
  then
    base_branch=$1
  fi
  echo "\nUpdating $curr_branch with $base_branch"
  gco $base_branch && gp && gco $curr_branch && grb $base_branch

  # If previous command resulted in an error, go back to the initial branch
  if [ $? != 0 ]
  then
    gco $curr_branch
  fi
}

# bundle
alias b='bundle'
alias be='bundle exec'
alias ber='bundle exec rspec'
alias berc='bundle exec rails c'

alias kc='kubectl'

alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias ll="ls -lah"

alias mysource="source ~/.zshrc"

eval "$(rbenv init -)"

# aliases to preserve text color when piping to less
alias rgl="rg --color=always"
alias ggl="gg --color=always"

export EDITOR=vim
export PATH="$HOME/.rbenv/shims:$PATH"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/

function kc-use_context() {
  CONTEXT="k8s.qa.credible.com"
  if [ $1 = "production" ]
  then
      CONTEXT="k8s.credible.com"
  fi

  kc config use-context "$CONTEXT"
}

function kc-ssh() {
  local POD=$(kc-get_pod $1 $2)
  local SHELL="bash"
  if [[ $1 =~ -fe$ ]]
  then
    SHELL="sh"
  fi

  # output a newline for nicer formatting
  echo
  kc --context $(kc-context $2) -n $2 exec -it $POD -- $SHELL
}

function kc-versions() {
  local WIDE_INDEX=7

  #if [ "production" = $1 ]
  #then
    #local CONTEXT="k8s.credible.com"
    ##local WIDE_INDEX=8 # delete this once production is upgraded
  #fi

  kc get deployments -n $1 -o wide --context $(kc-context $1) | awk '{split($0,a,"\ "); print a[7]}' | awk '{split($0,a,"\/"); print a[2]}' | awk '{split($0,a,"_"); print a[1]}' | sort -k1 | uniq
}

kc-get_pods() {
  kc --context $(kc-context $2) get pods -n $2 | grep $1
}

kc-get_pod() {
  kc-get_pods $1 $2 | cut -d " " -f 1 | head -n 1
}

kc-context() {
  local context="k8s.qa.credible.com"
  if [ "production" = $1 ]
  then
    local context="k8s.credible.com"
  fi
  echo $context
}

function kc-pf() {
  local port=$2
  local namespace="qa"
  if [ ! -z "$3" ]
  then
    namespace=$3
  fi
  local POD=$(kc-get_pod $1 vault)
  kc --context $(kc-context $namespace) port-forward $POD -n vault $port
}

function kc-log() {
  local POD=$(kc-get_pod $1 $2)
  kc --context $(kc-context $2) -n $2 logs $POD
}

kc-get_deployments() {
  kc --context=$(kc-context $2) -n $2 get deployments -o=name | grep $1 | perl -pe "s/^.+\///g"
}

kc-restart() {
  kc-get_deployments $1 $2 | xargs kubectl -n $2 --context=$(kc-context $2) rollout restart deployment
}

# iterm2 stuff
source ~/.iterm2_shell_integration.zsh
iterm2_print_user_vars() {
  #iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
  if [[ `pwd` = *"/code/"* ]]
  then
    app=`pwd | cut -d '/' -f 5`
    # app=${app#'credible-'}
    # app=${app#'credible_'}
    iterm2_set_user_var app $app
  else
    iterm2_set_user_var app ""
  fi
}

# Create backup file with mtime appended to filename
bu() {
  local file=$1
  local mtime=$(GetFileInfo -d $file | cut -d " " -f 1)
  local dates=($(echo $mtime | tr '/' '\n'))
  local datestamp="$dates[3]$dates[1]$dates[2]"
  local backup="$file.$datestamp"
  cp $file $backup
  echo "\nBacked up $file to $backup"
}

backup_dotfiles() {
}

baudit_ignore() {
  bundle exec bundler-audit | grep Advisory: | perl -pe "s/Advisory: (\S+)\n/\1 /"
}

cdgem() {
  local gem=$1
  local dir=$(b show $gem)
  if [ -d "$dir" ]
  then
    cd $dir
  fi
}

# python functions and aliases
alias pip3="python3 -m pip"
eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"

pyactivate() {
  local env='env'
  if [ ! -z $1 ]; then
    env=$1
  fi
  source $env/bin/activate
}

#ctags=/usr/local/bin/ctags

export GOPATH=$HOME/code/go
export PATH=$PATH:/usr/local/go/bin

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"

# From https://gist.github.com/bmhatfield/cc21ec0a3a2df963bffa3c1f884b676b dpr 2017-01-01

# In order for gpg to find gpg-agent, gpg-agent must be running, and there must be an env
# variable pointing GPG to the gpg-agent socket. This little script, which must be sourced
# in your shell's init script (ie, .bash_profile, .zshrc, whatever), will either start
# gpg-agent or set up the GPG_AGENT_INFO variable if it's already running.

# Add the following to your shell init to set up gpg-agent automatically for every shell
#if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
#    source ~/.gnupg/.gpg-agent-info
#    export GPG_AGENT_INFO
#else
#    eval $(gpg-agent --daemon)
#fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# place this after nvm initialization!
#autoload -U add-zsh-hook
#load-nvmrc() {
#  local node_version="$(nvm version)"
#  local nvmrc_path="$(nvm_find_nvmrc)"
#
#  if [ -n "$nvmrc_path" ]; then
#    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
#
#    if [ "$nvmrc_node_version" = "N/A" ]; then
#      nvm install
#    elif [ "$nvmrc_node_version" != "$node_version" ]; then
#      nvm use
#    fi
#  elif [ "$node_version" != "$(nvm version default)" ]; then
#    echo "Reverting to nvm default version"
#    nvm use default
#  fi
#}
#add-zsh-hook chpwd load-nvmrc
#load-nvmrc
#function nvm_auto_switch --on-variable PWD
#  if test -e '.nvmrc'
#      nvm use
#  end
#end

export PATH="/usr/local/opt/elasticsearch@6/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"

