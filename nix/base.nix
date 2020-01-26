{ config, pkgs, ...}:

{

  time.timeZone = "Europe/Warsaw";

  # Firewall
  networking.firewall.enable = false;
  networking.firewall.allowedTCPPorts = [ 21 80 443 ];
  networking.firewall.allowPing = true;

  nix.trustedUsers = [ "root" "jobo" ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    ncdu
    psmisc
    stow
    tree
    unzip
    wget
  ];
}
