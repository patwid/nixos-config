{ lib, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.efiSysMountPoint = lib.mkDefault "/boot/efi";
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

  boot.tmp.useTmpfs = true;
}
