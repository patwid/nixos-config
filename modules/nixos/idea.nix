{ config, lib, ... }:
let
  inherit (config) laptop;
in
{
  options = {
    ideaExtraVmopts = lib.mkOption {
      type = lib.types.str;
      default = ''
        -Xmx8g
        -Xms8g
      '';
    };
  };

  config = lib.mkIf (laptop) {
    ideaExtraVmopts = ''
      -Xmx4g
      -Xms4g
    '';
  };
}
