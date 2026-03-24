{
  pkgs,
  ...
}:
{
  # Required to unlock session
  security.pam.services.swaylock = { };

  environment.systemPackages = [ pkgs.swaylock ];
}
