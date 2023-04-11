{ lib, ... }:
{
  options.remoteWork = lib.mkOption {
    default = false;
    type = lib.types.bool;
  };
}
