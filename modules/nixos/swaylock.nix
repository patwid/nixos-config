{
  config,
  ...
}:
let
  inherit (config) user;
in
{
  # Required to unlock session
  security.pam.services.swaylock = { };

  home-manager.users.${user.name} = {
    programs.swaylock.enable = true;
  };
}
