{ config, lib, ... }:
{
  options.bootloader = lib.mkOption {
    type = lib.types.enum [ "systemdboot" "grub" ];
  };

  config.boot.cleanTmpDir = true;
}
