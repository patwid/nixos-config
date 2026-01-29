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
      position = {
        _attrs = {
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11";
}
