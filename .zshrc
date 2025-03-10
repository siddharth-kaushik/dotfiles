# Activate ZSH completion
autoload -Uz compinit && compinit
zmodload -i zsh/complist

# Allow substitution in prompt
setopt promptsubst

# Increase history size
HISTSIZE=32768
HISTFILESIZE=$HISTSIZE
HISTCONTROL="ignoreboth"

# Enable colors
export CLICOLOR=1

# Command Prompt Customizations
# List of emojis for the prompt
EMOJIS=(🐳 🌀 🦊 🐙 🦕 ⚡️ 🍀 ⛺️ 🎃 🍄 🍎 🍑 🍭)

# Set a random emoji in the prompt
setEmoji() {
  local emoji=${EMOJIS[$((RANDOM % ${#EMOJIS[@]} + 1))]}
  PS1="%F{yellow}%n%f %c%F{green}\$(git rev-parse --is-inside-work-tree 2>/dev/null && __git_ps1)%f $emoji $ "
}

# Initialize with a random emoji
setEmoji
alias e=setEmoji

# Map Python to Python3
alias python='python3'

# VSCode Insiders
alias ci="code-insiders"

# Source ZSH profiles
alias sb="source $HOME/.zshrc"

# Directory Traversal/Listing
alias ~="cd $HOME"
alias cl="clear"
alias ll="ls -1a"
alias ..="cd ../"
alias s="cd $HOME/Sites"
alias dot="cd $DOTFILES"

# Find and remove all 'node_modules' folders
alias farm="find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +"

# Delete .DS_Store files recursively
alias dds="find . -name '.DS_Store' -type f -delete"

# Flush DNS
alias flush-dns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# Open Chrome with CORS disabled
alias chrome-cors="open -a Google\ Chrome --args --disable-web-security --allow-file-access-from-files"

# NPM/Yarn Flush
alias nf="rm -rf node_modules/ package-lock.json && npm i && say 'NPM flush complete.'"
alias yf="rm -rf node_modules/ yarn.lock && yarn && say 'Yarn flush complete.'"

# Git Aliases
alias ga="git add ."
alias gc="git checkout"
alias gcb="git checkout -b"
alias gp="git pull"
alias gpo="git push origin"
alias grh="git reset --hard HEAD~"

# Symlink Dotfiles
function symLink() {
  ln -sf $HOME/.dotfiles/.gitconfig $HOME/.gitconfig
  ln -sf $HOME/.dotfiles/.gitignore_global $HOME/.gitignore_global
  ln -sf $HOME/.dotfiles/.stCommitMsg $HOME/.stCommitMsg
  ln -sf $HOME/.dotfiles/.zshrc $HOME/.zshrc
  ln -sf $HOME/.dotfiles/git-prompt.sh $HOME/git-prompt.sh
}

# Path to DotFiles
export DOTFILES=$HOME/.dotfiles

# ZSH auto-suggestions
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Ruby
export GEM_HOME="$HOME/.gem"
export PATH="$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init - zsh)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load nvm bash_completion

# MySQL
export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/mysql@5.7/lib"
export CPPFLAGS="-I/opt/homebrew/opt/mysql@5.7/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql@5.7/lib/pkgconfig"

# ImageMagick
export PATH="/opt/homebrew/opt/imagemagick@6/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/imagemagick@6/lib"
export CPPFLAGS="-I/opt/homebrew/opt/imagemagick@6/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/imagemagick@6/lib/pkgconfig"

# OpenSSL
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

# Terraform Completion
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Ruby Path
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
