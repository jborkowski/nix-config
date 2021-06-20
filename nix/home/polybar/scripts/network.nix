{ pkgs, ...}:

let
  ethtool = "${pkgs.ethtool}/bin/ethtool";
  rg      = "${pkgs.ripgrep}/bin/rg";
  wc      = "/run/current-system/sw/bin/wc";

  # Asus Z390
  eth1  = "eno2";
  wifi1 = "wlo1";

  # Apple MBP13 A1520
  wifi2 = "wlp3s0";
in
  pkgs.writeShellScriptBin "check-network" ''
    if [[ $1 = "eth" ]]; then
      eth1=$(${ethtool} ${eth1} 2>/dev/null | ${rg} "Link detected: yes" | ${wc} -l)
      if [[ $eth1 -eq 1 ]]; then
        echo ${eth1}
      else
        echo ""
      fi
    elif [[ $1 = "wifi" ]]; then
      wifi1=$(${ethtool} ${wifi1} 2>/dev/null | ${rg} "Link detected: yes" | ${wc} -l)
      wifi2=$(${ethtool} ${wifi2} 2>/dev/null | ${rg} "Link detected: yes" | ${wc} -l)
      if [[ $wifi1 -eq 1 ]]; then
        echo ${wifi1}
      elif [[ $wifi2 -eq 1 ]]; then
        echo ${wifi2}
      else
        echo ""
      fi
    else
      echo ""
    fi
  ''