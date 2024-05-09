{ config, lib, ... }:
let
  inherit (config.boot.tmp) useTmpfs;
in
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.efiSysMountPoint = lib.mkDefault "/boot/efi";
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

  boot.tmp.useTmpfs = lib.mkDefault true;
  boot.tmp.cleanOnBoot = !useTmpfs;
}
