# -> Active the ZSH completion
autoload -Uz compinit && compinit
zmodload -i zsh/complist

# Allow substitution in prompt
setopt promptsubst

# Make VSCode the default editor
export EDITOR="c"

# -> Increase history size to 32³, default is 500
HISTSIZE='32768';
HISTFILESIZE="${HISTSIZE}";
HISTCONTROL="ignoreboth"

# Toggle colors
export CLICOLOR=1;

# -> Command Prompt Customizations
green="\[\033[0;32m\]"
blue="\[\033[0;34m\]"
purple="\[\033[0;35m\]"
reset="\[\033[0m\]"

# List of emojis to choose from
array=(🐳 🌀 🦊 🐙 🦕 ⚡️ 🍀 ⛺️ 🎃 🍄 🍎 🍑 🍭)

# Set emoji in Command Prompt
setEmoji() {
  emoji=$@
  PS1="%F{yellow}%n%f %c%F{green}\$(__git_ps1)%f $emoji $ "
}
# Select a random emoji from list
randEmoji() {
  r=$(( $RANDOM % ${#array[@]} + 1))
  setEmoji ${array[${r}]}
}
randEmoji

# -> Set Prompt String
# '%n' adds the current 'username' to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '%f' resets the color
# git-prompt.sh -> add git related status to command prompt
# GIT_PS1_SHOWDIRTYSTATE -> shows unstaged (*) and staged (+) changes to the next of branch name
# GIT_PS1_SHOWCOLORHINTS -> Colored hint about the current dirty state
source ~/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
setopt PROMPT_SUBST
PS1="%F{yellow}%n%f %c%F{green}\$(__git_ps1)%f $emoji $ "


# -> Aliases
# Emit random emoji for prompt
alias e=randEmoji

# Map Python to Python3
alias python='python3'


# VSCode & VSCode Insiders
alias c="code"
alias ci="code-insiders";

# Open/Source ZSH profiles
alias cb="ci ~/.zshrc"
alias sb="source ~/.zshrc";

# Directory Traversal/ Listing
alias ~="cd ~"
alias cl="clear";
alias ll="ls -1a";
alias ..="cd ../";
alias s="cd ~/Sites";
alias x="cd ~/Sites/xwp";

# Show/ hide files or folders in finder
alias show="chflags nohidden"
alias hide="chflags hidden"

# Show/ hide status bar for finder
alias show-status-bar="defaults write com.apple.finder ShowStatusBar -bool true"
alias hide-status-bar="defaults write com.apple.finder ShowStatusBar -bool false"

# SHow/ hide path bar in finder
alias show-path-bar="defaults write com.apple.finder ShowPathbar -bool true"
alias hide-path-bar="defaults write com.apple.finder ShowPathbar -bool false"

# Find and remove all 'node_modules' folder in a directory
alias farm="find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +";

# Delete .DS_Store files
alias dds="find . -name '.DS_Store' -type f -delete";

# Flush DNS
alias flushdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder";

# Open Chrome with disabled CORS
alias chrome-cors="open -a Google\ Chrome --args --disable-web-security --allow-file-access-from-files";

# React
# eslint                  -> linter for Javascript and Typescript
# babel-eslint            -> transpiler for eslint, eslint doesn't understand React/ JSX very well
# eslint-config-prettier  -> makes eslint work with Prettier
# eslint-plugin-react     -> helps implement React rules
# eslint-plugin-import    -> helps implement some good habits when inporting/ exporting stuff
# eslint-plugin-jsx-a11y  -> helps implement good accessibility habits with React/ JSX
alias eslint-react="npm i -D eslint babel-eslint eslint-config-prettier eslint-plugin-react eslint-plugin-react-hooks eslint-plugin-import eslint-plugin-jsx-a11y";
alias tslint-react="npm i -D tslint tslint-react tslint-config-prettier";

# NPM
alias na="npm i";
alias nad="npm i -D";
alias nag="npm i -g";
alias nr="npm uninstall";
alias nu="npm upgrade";
alias nl="npm list -g --depth=0";
alias nf="rm -rf node_modules && npm i && say \"NPM flush complete.\"";
alias ncu="ncu --color"

# Yarn
alias ya="yarn add";
alias yad="yarn add -D";
alias yag="yarn global add";
alias yr="yarn remove";
alias ys="yarn serve";
alias yb="yarn build";
alias yu="yarn upgrade-interactive --latest";
alias yl="yarn global list";
alias yf="rm -rf node_modules && yarn && say \"Yarn flush complete.\"";

# Gulp
alias gulpi="yad gulp-ruby-sass gulp-autoprefixer gulp-cssnano gulp-jshint gulp-sourcemaps gulp-concat gulp-uglify gulp-imagemin gulp-webserver gulp-rename gulp-livereload gulp-cache del";

# Eslint
alias eslint-prettier="yad prettier eslint-config-prettier eslint-plugin-prettier";

# Git
function gc { git commit -m $@; }
alias ga="git add .";
alias gb="git checkout -b"
alias gbd="git branch -d"
alias gd="git diff";
alias gf="git fetch";
alias gpull="git pull";
alias gpush="git push";
alias gs="git status";
alias rh="git reset --hard HEAD";
alias unstage="git reset --soft HEAD";

function extract {
  if [ ! -d "./all" ]
  then
    mkdir all
  fi
  find . -name $@ | while
    IFS= read -r item;
    do
      folderName=${item%/*};
      itemName=${item##*/};
      mv ${item} ./all/${folderName##*/}-${itemName}
    done;
}


# -> Custom Functions
# Install Mac apps using Homebrew
initMac() {
  # Brew
  say "installing Homebrew";
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)";

  # Core
  say "installing Homebrew packages";
  brew install \
    composer \
    deno \
    dnsmasq \
    nginx \
    gh \
    git \
    mpv \
    serve \
    tree \
    wget \
    wp-cli \
    yarn;

  # CLIs
  say "installing Angular and Vue cli";
  yarn global add @angular/cli;
  yarn global add @vue/cli;

  # Cask
  say "installing apps from Homebrew cask";
  brew cask install \
    adobe-creative-cloud \
    alfred \
    android-file-transfer \
    android-studio \
    bitbar \
    coteditor \
    docker \
    dropbox \
    duet \
    figma \
    firefox-developer-edition \
    flux \
    github \
    googleappengine \
    google-backup-and-sync \
    google-chrome \
    homebrew/cask-versions/visual-studio-code-insiders \
    itsycal \
    imageoptim \
    jetbrains-toolbox \
    keybase \
    microsoft-edge \
    microsoft-teams \
    microsoft-word \
    microsoft-excel \
    microsoft-powerpoint \
    notion \
    opera \
    postgres \
    postico \
    postman \
    qbittorrent \
    sequel-pro \
    slack \
    sketchbook \
    skype \
    sourcetree \
    spectacle \
    spotify \
    telegram \
    the-unarchiver \
    visual-studio-code \
    vlc \
    whatsapp \
    zeplin;

    brew cleanup;
    brew cask cleanup;



  # NVM
  say "installing NVM";
  /bin/bash -c "$(curl -fsSL  https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh)";

  say "installing stable and latest version of Node";
  nvm install node;
  nvm install node --lts;


  # Show status bar and path bar in Finder
  say "turning on the status bar and path bar in Finder";
  defaults write com.apple.finder ShowPathbar -bool true;
  defaults write com.apple.finder ShowStatusBar -bool true;

  say "install following apps manually";
  printf "
    Apps from Creative Cloud \n
    JetBrains apps: PyCharm, PhpStorm, GoLand, IntelliJ \n
    Pages, Numbers, Keynote \n
    Lynda.com \n
    Svgsus \n
    Webponize \n
    Xcode \n
  ";
}

linkDotfiles() {
  ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
  ln -s ~/.dotfiles/.gitignore_global ~/.gitignore_global
  ln -s ~/.dotfiles/.stCommitMsg ~/.stCommitMsg
  ln -s ~/.dotfiles/..zshrc ~/..zshrc
  ln -s ~/.dotfiles/git-prompt.sh ~/git-prompt.sh
}


# Configure VS Code as default editor tool for git
setVSCodeForGit() {
  # default editor tool
  git config --global core.editor "code --wait"

  # default diff tool
  git config --global diff.tool vscode
  git config --global difftool.vscode.cmd "code --wait --diff $LOCAL $REMOTE"

  # default merge tool
  git config --global merge.tool vscode
  git config --global mergetool.vscode.cmd "code --wait $MERGED"
}


# Remove Meta-Info of a File
removeMeta() {
  xattr $@
  xattr -d com.apple.metadata:kMDItemWhereFroms $@
}

# Toggle sidecar ON/ OFF
toggleSidecar() {
  defaults write com.apple.sidecar.display AllowAllDevices -bool $@;
  defaults write com.apple.sidecar.display hasShownPref -bool $@;

  # Show Sidecar panel
  defaults write com.apple.sidecar.display AllowAllDevices -bool $@;
  defaults write com.apple.sidecar.display hasShownPref -bool $@;
}

# Toggle drop-shadows for screen captures
toggleScreenshotShadows() {
  defaults write com.apple.screencapture disable-shadow -bool $@;
  killall SystemUIServer;
}

# Add spacer tile on Dock
addSpacerTile() {
  defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}';
  killall Dock;
}

# -> Path Alterations
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# RUST
export PATH="$HOME/.cargo/bin:$PATH"

# Java
alias java="/Library/Java/JavaVirtualMachines/jdk-11.jdk/Contents/Home/bin/java"

# -> ZSH completion
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# Deno completions
fpath=(~/.zsh $fpath)
autoload -Uz compinit
compinit -u

# Deno cache alias
alias dc="cd /Users/sid/Library/Caches/deno && ll"
export PATH="/usr/local/opt/ffmpeg@2.8/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/ffmpeg@2.8/lib/pkgconfig"
