stty -ixon

export CREDIBLE_DIR=~/credible
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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

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
alias grs='git reset --soft HEAD~1'
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

gu() {
  local curr_branch=$(git rev-parse --abbrev-ref HEAD)
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

# bundle
alias b='bundle'
alias be='bundle exec'

alias kc='kubectl'

alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias ll="ls -lah"

alias mysource="source ~/.zshrc"

eval "$(rbenv init -)"

alias pip3="python3 -m pip"

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
  local POD=$(kc-get_pods $1 $2)
  # output a newline for nicer formatting
  echo
  kc --context $(kc-context $2) -n $2 exec -it $POD -- bash
  #kc -n $2 exec -it $(kc get pods -n $2 | grep $1 | cut -d " " -f 1 | head -n 1) bash
#  case "$2" in
#   production)
#     kc config use-context k8s.credible.com
#     ;;
#   *)
#     kc config use-context k8s.qa.credible.com
#     ;;
#  esac
#  case "$1" in
#   credible-api)
#    kc exec $(kc get pods -n $2 | grep 'credible-api-api-[^ratealerts]' | awk '{print $1}' | head -n 1) -n $2 -it bash
#    ;;
#   credible-partners-api)
#    kc exec $(kc get pods -n $2 | grep 'credible-partners-api-api' | awk '{print $1}' | head -n 1) -n $2 -it bash
#    ;;
#   credible-new-be)
#    kc exec $(kc get pods -n $2 | grep 'credible-new-be-api' | awk '{print $1}' | head -n 1) -n $2 -it bash
#    ;;
#   credible-admin)
#    kc exec $(kc get pods -n $2 | grep 'credible-admin' | awk '{print $1}' | head -n 1) -n $2 -it bash
#    ;;
#   *)
#    echo "Usage: $0 {project} {env}"
#    return 1
#    ;;
#  esac
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
  kc --context $(kc-context $2) get pods -n $2 | grep $1 | cut -d " " -f 1 | head -n 1
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
  local POD=$(kc-get_pods $1 vault)
  kc --context $(kc-context $namespace) port-forward $POD -n vault $port
}

function kc-log() {
  local POD=$(kc-get_pods $1 $2)
  kc --context $(kc-context $2) -n $2 logs $POD
}

# iterm2 stuff
source /Users/leewang/.iterm2_shell_integration.zsh
iterm2_print_user_vars() {
  #iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
  if [[ `pwd` = *"/credible/"* ]]
  then
    app=`pwd | cut -d '/' -f 5`
    app=${app#'credible-'}
    app=${app#'credible_'}
    iterm2_set_user_var credible_app $app
  else
    iterm2_set_user_var credible_app ""
  fi
}


#ctags=/usr/local/bin/ctags

export GOPATH=$HOME/code/go
export PATH=$PATH:/usr/local/go/bin
