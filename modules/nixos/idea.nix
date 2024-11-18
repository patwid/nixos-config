{ lib, ... }:
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
}
