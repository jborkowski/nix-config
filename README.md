# My Nix configuration

## On macOS & Linux (not nixOS)

Use this method on macOS and other Linux distros including ChromeOS's crostini container.

1. Install [home-manager](https://github.com/rycee/home-manager)
1. `ln -s ~/projects/nix-config/nix/home.nix ~/.config/nixpkgs/home.nix`
1. `mkdir old-profile; mv .bashrc .profile old-profile`
1. `home-manager switch`

Consider to use [link](https://github.com/jeaye/nixos-in-place) for install nixOS on top of other linux.
Before run install.sh script, patch the configuration.nix used by it to allow root logins
see [BUG](https://github.com/jeaye/nixos-in-place/issues/43)

Strongly inspired by [link](https://github.com/srid/nix-config) 

TODO: https://github.com/nix-community/emacs-overlay