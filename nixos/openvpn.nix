{ config, pkgs, ...}:

{
  systemd.services = {
    cortb = {
      description = "CoRTB connection";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.openvpn}/bin/openvpn /home/jonatanb/vpn/cortb/hcore-vpn-config.ovpn";
      };
    };
  };
}
