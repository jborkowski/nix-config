# My Nix configuration

## NixOS configuration
Clone repository 
```
git clone https://github.com/jborkowski/nix-config.git ~/
```
Add and update channels:
```
$ nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
$ nix-channel --add https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz home-manager
$ nix-channel --update
```
Install Home Manager
```
$ mkdir -p $HOME/.config/nixpkgs/
$ nix-shell '<home-manager>' -A install
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


