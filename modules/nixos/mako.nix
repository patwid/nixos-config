{
  inputs,
  config,
  pkgs,
  ...
}:
let
  inherit (config) colors;
in
{
  imports = [ inputs.nix-wrapper-modules.nixosModules.mako ];

  wrappers.mako = {
    enable = true;
    settings = {
      font = "sans-serif 10";
      icons = "false";
      padding = "8";
      border-size = "1";
      background-color = colors.backgroundInactive;
      border-color = colors.backgroundActive;
      progress-color = "over ${colors.red}"; # TODO: usage?
      text-color = colors.foreground;
    };
  };

  environment.systemPackages = [ pkgs.libnotify ];
}
