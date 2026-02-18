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
  inherit (config) laptop work ideaVmopts;

  vmopts = ''
    -Dawt.toolkit.name=WLToolkit
  '' + ideaVmopts;

  # Overriding vmopts and forceWaylang flag of idea pkg
  # does not seem to work properly
  idea = pkgs.jetbrains.idea.override {
    inherit vmopts;
    forceWayland = true;
  };

  ideaPlugins =
    pluginsForIde pkgs idea [
      "IdeaVIM"
    ]
    |> builtins.attrValues;
in
{
  options = {
    ideaVmopts = lib.mkOption {
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
      ideaVmopts = ''
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
