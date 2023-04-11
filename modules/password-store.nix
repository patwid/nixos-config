{ args, ... }:
let
  inherit (args) user;
in
{
  nixpkgs.overlays = [
    (self: super: {
      pass = super.pass.override { dmenuSupport = false; };
    })
  ];

  home-manager.users.${user} = {
    programs.password-store.enable = true;
  };
}
