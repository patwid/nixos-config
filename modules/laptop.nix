{ config, args, lib, pkgs, ... }:
let
  inherit (args) user;
in
{
  options.laptop = lib.mkOption {
    default = false;
    type = lib.types.bool;
  };

  config = lib.mkIf config.laptop {
    services.tlp.enable = true;

    home-manager.users.${user} = {
      home.packages = [ pkgs.brightnessctl ];
    };
  };
}
