{ inputs, pkgs, ... }:
let
  inherit (inputs) nixos-hardware;
in
{
  imports = with nixos-hardware.nixosModules; [
    common-cpu-intel
    common-gpu-amd
    common-pc
    common-pc-ssd
  ];

  user.uid = 1795;
  group.name = "ergon";
  group.gid = 1111;
  work.enable = true;

  outputs = {
    DP-2 = {
      position = _: {
        props = {
          x = 0;
          y = 0;
        };
      };
    };
  };

  services.printing.enable = true;

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs) hplip;
  };

  system.stateVersion = "22.11";
}
