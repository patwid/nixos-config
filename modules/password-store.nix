{ config, ... }:
let
  inherit (config) user;
in
{
  imports = [
    ./gpg.nix
  ];

  nixpkgs.overlays = [
    (self: super: {
      pass = super.pass.override { dmenuSupport = false; };
    })
  ];

  home-manager.users.${user.name} = {
    programs.password-store.enable = true;
  };
}
