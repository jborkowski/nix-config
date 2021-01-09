# My Nix configuration

## NixOS configuration
Clone repository 
```
git clone https://github.com/jborkowski/nix-config.git ~/
```
Add and update channels:
```
$ sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
$ sudo nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
$ sudo nix-channel --update
```
Install Home Manager
```
$ mkdir -p $HOME/.config/nixpkgs/
$ sudo nix-shell '<home-manager>' -A install
```
Make symlinks
```
$ sudo ln -s ~/nix-config/nix/home.nix ~/.config/nixpkgs/home.nix
$ sudo ln -s ~/nix-config/nixos/machine/a1502.nix /etc/nixos/configuration.nix
```

```
sudo nixos-rebuild switch
home-manager switch
```


