{ config, lib, ... }:
let
  inherit (config) apple-silicon;
in
lib.mkIf (apple-silicon) {
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.efi.efiSysMountPoint = "/boot";
}
