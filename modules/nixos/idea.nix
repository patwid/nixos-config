{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config)
    laptop
    work
    user
    ideaVmopts
    ;

  vmopts = ''
    -Dawt.toolkit.name=WLToolkit
  ''
  + ideaVmopts;

  # Overriding vmopts and forceWaylang flag of idea pkg
  # does not seem to work properly
  idea = pkgs.jetbrains.idea.override {
    inherit vmopts;
    forceWayland = true;
  };
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
        idea
      ];

      environment.etc."xdg/ideavim/ideavimrc".text = ''
        set clipboard+=unnamedplus,ideaput
        set ideajoin
      '';
    })
  ];
}
