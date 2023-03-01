{ args, ... }:
{
  imports = [
    ./gpg.nix
  ];

  nixpkgs.overlays = [
    (self: super: {
      pass = super.pass.override { dmenuSupport = false; };
    })
  ];

  home-manager.users.${args.user} = {
    programs.password-store.enable = true;
  };
}
