# shellcheck shell=bash
# shellcheck disable=SC2034
# shellcheck disable=SC1090

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/rsilva/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Excludes IRB from bundler plugin
UNBUNDLED_COMMANDS=(irb)

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  aws
  brew
  bundler
  docker
  docker-compose
  git
  git-changelog
  kubectl
  opsworks-connect
  osx
  rails
  ruby
  rvm
  z
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration
export GPG_TTY=$(tty)

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export EDITOR=code

function edit() { "${EDITOR}" -w "$@"; }
function edit_settings() { edit "$@"; source "$@"; }

#mkdir and cd
function mkcd() { mkdir -p "$1" && cd "$_" || exit; }

# FileSearch
function f() { find . -iname "*$1*" "${@:2}"; }
function r() { grep "$1" "${@:2}" -R .; }

# Copies .sample/.example files, removing the .sample/.example extension
function unsample() {
  for file in **/?(.)*.@(sample|example); do
    cp "$file" "${file/.(sample|example)/}"
  done
}

# Custom aliases
alias zrc="edit_settings ~/.zshrc"
alias omz="edit_settings ~/.oh-my-zsh"
alias pl10k="edit_settings ~/.p10k.zsh"
alias bnfo="bundle info"

# Load NVM hooks
source ~/scripts/nvm.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/rsilva/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/rsilva/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/rsilva/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/rsilva/google-cloud-sdk/completion.zsh.inc'; fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
