{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) user;
  pass = lib.getExe pkgs.pass-wayland;
in
{
  imports = [
    (inputs.nix-wrapper-modules.lib.mkInstallModule {
      name = "senpai";
      value = ./_wrappers/senpai.nix;
    })
  ];

  wrappers.senpai = {
    enable = true;
    settings = {
      address = "chat.sr.ht";
      nickname = user.name;
      password-cmd = [
        pass
        "srht/chat"
      ];
    };
  };
}
