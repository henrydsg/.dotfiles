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
[[ "$(stow --version)" == *"command not found"* ]] && brew install stow
if [[ "$(stow --version)" == *"command not found"* ]]; then
  echo "stow is not installed successfully."
  abort 1
fi

STOW_ERR_MSG="$(stow -d $SCRIPTPATH -t $HOME --restow . 2>&1;)";
if [[ "$STOW_ERR_MSG" ==  *"conflicts:"* ]]; then
  echo "$STOW_ERR_MSG"
  abort 1
fi

# nvim
[[ "$(nvim --version;)" == *"command not found"* ]] && \
  brew install --HEAD neovim
if [[ "$(nvim --version;)" == *"command not found"* ]]; then
  echo "neovim is not installed successfully"
  abort 1
fi

# hack-nerd-font (for nvim lsp functions)
if [ -z "$(ls $HOME/Library/Fonts | grep Nerd;)" ]; then
  brew tap homebrew/cask-fonts 
  brew install --cask font-hack-nerd-font
fi

# oh-my-zsh
[ ! -d ~/.oh-my-zsh ] &&  \
  sh -c "$(curl -fssl https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --keep-zshrc
if [ ! -d ~/.oh-my-zsh ]; then
  echo "oh-my-zsh is not installed."
  abort 1
fi

# fzf and ag needs to be installed before plugged by oh-my-zsh
[[ "$(fzf --version)" == *"command not found"* ]] && brew install fzf
if [[ "$(fzf --version;)" == *"command not found"* ]]; then
  echo "fzf is not installed successfully"
  abort 1
fi

[[ "$(ag --version)" == *"command not found"* ]] && brew install the_silver_searcher
if [[ "$(ag --version;)" == *"command not found"* ]]; then
  echo "the_silver_searcher is not installed successfully"
  abort 1
fi

[[ "$(bat --version)" == *"command not found"* ]] && brew install bat
if [[ "$(bat --version;)" == *"command not found"* ]]; then
  echo "bat is not installed successfully"
  abort 1
fi

# iTerm2
[ -z "$(brew ls --cask --version iterm2;)" ] && brew install iterm2
if [ -z "$(brew ls --cask --version iterm2;)" ]; then
  echo "iTerm2 is not installed successfully."
  abort 1
fi

# git
[[ "$(git --version)" == *"command not found "* ]] && brew install git
if [[ "$(git --version)" == *"command not found "* ]]; then
  echo "git is not installed successfully."
  abort 1
fi

# tmux
[[ "$(tmux -V)" == *"command not found" ]] && brew install tmux
if [[ "$(tmux -V)" == *"command not found" ]]; then
  echo "tmux is not installed successfully."
  abort 1
fi

echo "Successfull. Please close current terminal and open a new iTerm2 to activate all configs."
