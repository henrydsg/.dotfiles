#!/bin/zsh
SCRIPTPATH="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)";

function abort () {
  echo "Dotfiles setup aborted."
  exit $1
}

# brew
[[ "$(brew --version)" == *"command not found"* ]] && \
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [[ "$(brew --version)" == *"command not found"* ]]; then
  echo "brew is not installed successfully."
  abort 1
fi

# stow
[ -z "$(brew ls --version stow;)" ] && brew install stow
STOW_ERR_MSG="$(stow -d $SCRIPTPATH -t $HOME --restow . 2>&1;)";
if [[ "$STOW_ERR_MSG" ==  *"conflicts:"* ]]; then
  echo "$STOW_ERR_MSG"
  abort 1
fi

# nvim
[ -z "$(brew ls --version neovim;)" ] && \
  brew install --HEAD neovim
if [ -z "$(brew ls --version neovim;)" ]; then
  echo "neovim is not installed successfully"
  abort 1
fi

# hack-nerd-font (for nvim lsp functions)
[ -z "$(brew ls --cask --version font-hack-nerd-font;)" ] && \
  brew tap homebrew/cask-fonts && \ 
  brew install --cask font-hack-nerd-font

# oh-my-zsh
[ ! -d ~/.oh-my-zsh ] &&  \
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --keep-zshrc
if [ ! -d ~/.oh-my-zsh ]; then
  echo "oh-my-zsh is not installed."
  abort 1
fi

# TODO: find a better way to manage these two plugins
# fzf and ag needs to be installed before plugged by oh-my-zsh
[ -z "$(brew ls --version fzf;)" ] && brew install fzf
[ -z "$(brew ls --version the_silver_searcher;)" ] && brew install the_silver_searcher

# iTerm2
[ -z "$(brew ls --cask --version iterm2;)" ] && brew install iterm2
if [ -z "$(brew ls --cask --version iterm2;)" ]; then
  echo "iTerm2 is not installed successfully."
  abort 1
fi

# git
[ -z "$(brew ls --version git;)" ] && brew install git
if [ -z "$(brew ls --version git;)" ]; then
  echo "git is not installed successfully."
  abort 1
fi

# tmux
[ -z "$(brew ls --version tmux;)" ] && brew install tmux
if [ -z "$(brew ls --version tmux;)" ]; then
  echo "tmux is not installed successfully."
  abort 1
fi

echo "Successfull."
