{ lib, ... }:
{
  options = {
    output = lib.mkOption {
      type = with lib; types.attrsOf (types.attrsOf types.str);
      default = { };
    };
  };
  config = {
    programs = {
      niri = {
        enable = true;
      };
    };
  };
}
