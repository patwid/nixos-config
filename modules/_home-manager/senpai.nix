{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (osConfig) user;

  pass = lib.getExe pkgs.pass-wayland;
in
{
  programs.senpai = {
    enable = true;
    config = {
      address = "chat.sr.ht";
      nickname = user.name;
      password-cmd = [
        pass
        "srht/chat"
      ];
    };
  };
}
