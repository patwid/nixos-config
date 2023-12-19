{ lib, ... }:
{
  options.terminal.fontsize = lib.mkOption {
    type = lib.types.int;
    default = 11;
  };
}
