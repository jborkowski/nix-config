{ config, lib, pkgs, ... }:

{
  services.redshift = {
    enable = true;
    brightness = {
      day = "1";
      night = "1";
    };
    temperature = {
      day = 5500;
      night = 3700;
    };
  };

  location = {
    latitude = 52.229676;
    longitude = 21.012229;
  };
}
