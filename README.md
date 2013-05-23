List of rake commands
* rake git_submodules_init  # Initialize and update git submodules
* rake install              # Install and update dotfiles (default)
* rake symlinks             # Create symlinks to dotfiles in home directory
* rake uninstall            # Remove dotfile symlinks from home directory
* rake vundle:install       # Update vim plugins with vundle

To install xcode templates, soft link from `xcode-templates` directory
to `~/Library/Developer/Xcode/Templates/File Templates`. 

Example: `ln -s ~/dotfiles/xcode-templates/ ~/Library/Developer/Xcode/Templates/File\ Templates`
