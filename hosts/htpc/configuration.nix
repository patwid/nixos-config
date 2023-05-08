{ args, pkgs, nixos-hardware, nixos-apple-silicon, ... }:
let
  inherit (args) user;
in
{
  imports = [
    nixos-hardware.nixosModules.common-pc
    nixos-hardware.nixosModules.common-pc-ssd

    # Unfortunately, optional imports lead to infinite recursion errors.
    # Therefore, we import the module here instead of in the apple-silicon
    # module.
    nixos-apple-silicon.nixosModules.apple-silicon-support
  ];

  apple-silicon = true;
  home.enable = true;

  # Unfortunately, these options are not recognized on x86_64-linux systems and
  # therefore cannot be specified in apple-silicon module.
  hardware.asahi.peripheralFirmwareDirectory = ../../firmware;
  hardware.asahi.useExperimentalGPUDriver = true;

  home-manager.users.${user} = {
    wayland.windowManager.sway = {
      config = {
        output.HDMI-A-1.scale = "2";
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05";
}
