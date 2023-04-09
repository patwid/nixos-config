{ lib, ... }:
{
    options.terminal = {
      fontsize = lib.mkOption {
        type = with lib.types; int;
      };
    };
}
