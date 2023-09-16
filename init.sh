#!/bin/bash

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Please install Homebrew(https://brew.sh/) before continuing."
    exit 1
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "Node.js is not installed. Please install Node.js(https://github.com/nvm-sh/nvm) before continuing."
    exit 1
fi

# Define an associative array to store relative source file paths and their corresponding target paths
declare -A symlinks

# Add your relative file-to-target mappings here
# Format: symlinks['relative_source_file']='full_target_file'
symlinks['gitconfig']='.gitconfig'
symlinks['gitignore_global']='.gitignore_global'
symlinks['tmux.conf']='.tmux.conf'
symlinks['zshrc']='.zshrc'
symlinks['vimrc']='.vimrc'
symlinks['kitty.conf']='.config/kitty/kitty.conf'
symlinks['nvim/init.vim']='.config/nvim/init.vim'
symlinks['vscode/settings.json']='Library/Application Support/Code/User/settings.json'

# Get your home directory
home_dir="$HOME"

# Loop through the associative array and create symbolic links
for source_rel in "${!symlinks[@]}"; do
    source="$PWD/$source_rel" # Construct the full source path

    # Construct the full target path starting with your home directory
    target="$home_dir/${symlinks[$source_rel]}"

    # Create the parent directories of the source file/directory if they don't exist
    parent_dir="$(dirname "$target")"
    mkdir -p "$parent_dir"

    # Create the symbolic link
    ln -s "$target" "$source"

    echo "Created symbolic link: $source -> $target"
done

echo "All symbolic links created successfully."

# Install plugin manager for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


# Install a bunch of software
brew install git
brew install zsh
brew install pure
brew install zsh-syntax-highlighting
brew install tmux
brew install tmuxinator
brew install neovim
brew install vim

# Setup terminal and fonts
brew install kitty
brew tap homebrew/cask-fonts && brew install font-fira-code-nerd-font

# Nice stuff for git/neovim
brew install colordiff
brew install diff-so-fancy
brew install fzy
brew install ripgrep
