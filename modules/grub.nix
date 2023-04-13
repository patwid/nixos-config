{ config, lib, ... }:
let
  inherit (config) bootloader;
in
lib.mkIf (bootloader == "grub") {
  boot.loader.grub.enable = true;
  boot.loader.grub.configurationLimit = 5;
  boot.loader.grub.device = "/dev/sda";
}
