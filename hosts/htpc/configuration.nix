{ nixos-hardware, ... }:
{
  imports = with nixos-hardware.nixosModules; [
    common-cpu-intel
    common-pc-laptop
  ];

  bootloader = "grub";
  laptop = true;
  home = true;
}
