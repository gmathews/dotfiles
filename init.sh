#!/bin/zsh

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Please install Homebrew(https://brew.sh/) before continuing."
    exit 1
fi

# Define an associative array to store relative source file paths and their corresponding target paths
typeset -A symlinks

# Add your relative file-to-target mappings here
symlinks=(
  'gitconfig' '.gitconfig'
  'gitignore_global' '.gitignore_global'
  'tmux.conf' '.tmux.conf'
  'zshrc' '.zshrc'
  'vimrc' '.vimrc'
  'kitty.conf' '.config/kitty/kitty.conf'
  'nvim/init.vim' '.config/nvim/init.vim'
  'starship.toml' '.config/starship.toml'
  'bat' '.config/bat/config'
  'vscode/settings.json' 'Library/Application Support/Code/User/settings.json'
)

# Get your home directory
home_dir="$HOME"

# Loop through the associative array and create symbolic links
for source_rel in "${(@k)symlinks}"; do
    source_file="$PWD/$source_rel" # Construct the full source path

    # Construct the full target path starting with your home directory
    target_file="$home_dir/${symlinks[$source_rel]}"

    # Create the parent directories of the source file/directory if they don't exist
    parent_dir="$(dirname "$target_file")"
    mkdir -p "$parent_dir"

    # Create the symbolic link
    ln -s "$source_file" "$target_file"

    echo "Created symbolic link: $source_file -> $target_file"
done

echo "All symbolic links created successfully."

# Install node
brew install fnm
fnm install 20

# Install plugin manager for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


# Install a bunch of software
brew install git
brew install zsh
brew install starship
brew install fzf # History search
brew install zsh-syntax-highlighting
brew install tmux
brew install reattach-to-user-namespace
brew install tmuxinator
brew install neovim

# Modern Unix stuff
brew install bat

# Setup terminal and fonts
brew install kitty
brew tap homebrew/cask-fonts && brew install font-symbols-only-nerd-font && brew install font-fira-code

# Nice stuff for git/neovim
brew install colordiff
brew install diff-so-fancy
brew install fzy
brew install ripgrep

echo "fix tmux terminal in git"
/usr/bin/tic -x tmux-256color.src
