# My Nix configuration
## How to use

```
ln -s /home/jobo/nix-config/nixos/machine/a1502.nix configuration.nix
ln -s home.nix ~/.config/nixpkgs/home.nix

# Manual steps
mkdir -p $HOME/.config/polybar/logs
touch $HOME/.config/polybar/logs/bottom.log
touch $HOME/.config/polybar/logs/top.log
mkdir -p $HOME/.cache/fzf-hoogle
touch $HOME/.cache/fzf-hoogle/cache.json
```
