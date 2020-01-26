{ config, pkgs, ...}:

{
  imports = [
    <home-manager/nixos>
  ];
  home-manager.users.jobo = (import ./home.nix);
}
