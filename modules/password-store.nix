{ args, ... }:
let
  inherit (args) user;
in
{
  home-manager.users.${user} = {
    programs.password-store.enable = true;
  };
}
