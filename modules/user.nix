{ lib, ... }:
{
  options.user = {
    name = lib.mkOption {
      type = with lib.types; str;
    };
    email = lib.mkOption {
      type = with lib.types; str;
    };
    group = lib.mkOption {
      type = with lib.types; str;
    };
    uid = lib.mkOption {
      type = with lib.types; nullOr int;
      default = null;
    };
    gid = lib.mkOption {
      type = with lib.types; nullOr int;
      default = null;
    };
  };
}
