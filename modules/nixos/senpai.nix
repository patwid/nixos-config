{
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
  home-manager.users.${user.name} = {
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
  };
}
