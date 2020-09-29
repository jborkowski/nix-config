{ config, lib, pkgs, ... }:

{
   services.postgresql = {
    enable = true;
    package = pkgs.postgresql_12;
    enableTCPIP = false;
    # https://nixos.wiki/wiki/PostgreSQL
    authentication = pkgs.lib.mkOverride 10
      ''
      local all all trust
      host all all ::1/128 trust
      '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE monadic WITH LOGIN PASSWORD 'monadic' CREATEDB;
      CREATE DATABASE monadic_test;
      GRANT ALL PRIVILEGES ON DATABASE monadic_test TO monadic;
    '';
  };

}
