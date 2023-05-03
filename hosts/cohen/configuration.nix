{ nixos-hardware, ... }:
{
  imports = with nixos-hardware.nixosModules; [
    common-cpu-intel
    common-gpu-amd
    common-pc
    common-pc-ssd
  ];

  bootloader = "systemdboot";
  work.enable = true;
}
