# -> Active the ZSH completion
autoload -Uz compinit && compinit
zmodload -i zsh/complist

# Allow substitution in prompt
setopt promptsubst

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
source $HOME/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
setopt PROMPT_SUBST
PS1="%F{yellow}%n%f %c%F{green}\$(__git_ps1)%f $emoji $ "


# -> Aliases
# Emit random emoji for prompt
alias e=randEmoji

# Map Python to Python3
alias python='python3'

# VSCode Insiders
alias ci="code-insiders";

# Source ZSH profiles
alias sb="source $HOME/.zshrc";

# Directory Traversal/ Listing
alias ~="cd $HOME"
alias cl="clear";
alias ll="ls -1a";
alias ..="cd ../";
alias s="cd $HOME/Sites";
alias dot="cd $DOTFILES";

# Find and remove all 'node_modules' folder in a directory
alias farm="find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +";

# Delete .DS_Store files recursively in a folder
alias dds="find . -name '.DS_Store' -type f -delete";

# Flush DNS
alias flushdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder";

# Open Chrome with CORS disabled
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

# WordPress and PHP
alias phpf="rm -rf vendor/ composer.lock && composer i"
alias wpcf="npx wp-env run cli \"wp cache flush\"";
alias wprf="npx wp-env run cli \"wp rewrite flush\"";

# NPM
alias na="npm i";
alias nad="npm i -D";
alias nag="npm i -g";
alias nr="npm uninstall";
alias nrb="npm run build";
alias nrl="npm run lint";
alias nu="npm upgrade";
alias nl="npm list -g --depth=0";
alias nf="rm -rf node_modules/ package-lock.json && npm i && say \"NPM flush complete.\"";

# Yarn
alias y="yarn";
alias ya="yarn add";
alias yad="yarn add -D";
alias yag="yarn global add";
alias yr="yarn remove";
alias yu="yarn upgrade-interactive --latest";
alias yl="yarn global list";
alias yf="rm -rf node_modules/ yarn.lock && yarn && say \"Yarn flush complete.\"";

# Gulp
alias gulpi="yad gulp-ruby-sass gulp-autoprefixer gulp-cssnano gulp-jshint gulp-sourcemaps gulp-concat gulp-uglify gulp-imagemin gulp-webserver gulp-rename gulp-livereload gulp-cache del";

# ESLint
alias eslint-prettier="yad prettier eslint-config-prettier eslint-plugin-prettier";

# Git
alias ga="git add .";
alias gb="git branch";
alias gbd="git branch -D";
alias gc="git checkout";
alias gcb="git checkout -b";
alias gcm="git checkout main";
alias gcom="git commit -m";
alias gd="git diff";
alias gf="git fetch";
alias gl="git log --oneline";
alias gm="git merge";
alias gma="git merge --abort";
alias gp="git pull";
alias gpo="git push origin";
alias gr="git reset HEAD~";
alias grh="git reset --hard HEAD";
alias grl="git branch -D `git branch --merged | grep -v \* | xargs`";
alias gs="git status";
alias gsp="git stash pop";
alias gsl="git stash list";


# -> Functions
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

# Install Mac apps using Homebrew
function initMac() {
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
  say "toggling on the status bar and path bar in Finder";
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

function symLink() {
  ln -s $HOME/.dotfiles/.gitconfig $HOME/.gitconfig
  ln -s $HOME/.dotfiles/.gitignore_global $HOME/.gitignore_global
  ln -s $HOME/.dotfiles/.stCommitMsg $HOME/.stCommitMsg
  ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
  ln -s $HOME/.dotfiles/git-prompt.sh $HOME/git-prompt.sh
}


# Configure VS Code as default editor tool for git
function setVSCodeForGit() {
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
function removeMeta() {
  xattr $@
  xattr -d com.apple.metadata:kMDItemWhereFroms $@
}

# Add an empty spacer tile to the Dock
function emptyDockTile() {
  defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}';
  killall Dock;
}

# Get current node version
function nodeVersion() {
  node -v
}

# -> Path Alterations
# Path to DotFiles
export DOTFILES=$HOME/.dotfiles

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# Deno
fpath=($HOME/.zsh $fpath)
autoload -Uz compinit
compinit -u

# ffmpeg
export PATH="/usr/local/opt/ffmpeg@2.8/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/ffmpeg@2.8/lib/pkgconfig"

# add PHP v7 to PATH for version switching
export PATH="/usr/local/opt/php@7.4/bin:$PATH"

# ZSH auto-suggestions
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


# -> Aliasing libraries
# Java
alias java="/Library/Java/JavaVirtualMachines/jdk-11.jdk/Contents/Home/bin/java"

# Load globalnode libraries
export PATH="$HOME/.nvm/versions/node/${nodeVersion}/bin:$PATH"

# Use project specific Node binaries before global ones
export PATH="node_modules/bin:vendor/bin:$PATH"
