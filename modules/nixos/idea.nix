{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (inputs.nix-jetbrains-plugins) plugins;
  inherit (inputs.nix-jetbrains-plugins.lib) pluginsForIde;
  inherit (config) laptop work ideaExtraVmopts;

  vmopts = ''
    -Dawt.toolkit.name=WLToolkit
  ''
  + ideaExtraVmopts;

  # Overriding vmopts of idea pkg does not seem to work
  idea = pkgs.jetbrains.idea.override {
    inherit vmopts;
  };

  ideaPlugins =
    pluginsForIde pkgs idea [
      "IdeaVIM"
    ]
    |> builtins.attrValues;
in
{
  options = {
    ideaExtraVmopts = lib.mkOption {
      type = lib.types.str;
      default = ''
        -Xmx8g
        -Xms8g
      '';
    };
  };

  config = lib.mkMerge [
    {
      # Workaround because overriding vmopts does not work
      environment.sessionVariables = {
        IDEA_VM_OPTIONS = vmopts |> lib.splitString "\n" |> lib.concatStringsSep " ";
      };
    }

    (lib.mkIf laptop {
      ideaExtraVmopts = ''
        -Xmx4g
        -Xms4g
      '';
    })

    (lib.mkIf work.enable {
      environment.systemPackages = [
        (pkgs.jetbrains.plugins.addPlugins idea ideaPlugins)
      ];
    })
  ];
}
