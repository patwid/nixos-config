{
  inputs,
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  inherit (osConfig) colors work ideaExtraVmopts;
  inherit (pkgs.stdenv.hostPlatform) system;
  inherit (inputs.nix-jetbrains-plugins) plugins;

  idea = pkgs.jetbrains.idea.override {
    vmopts =
      ''
        -Dawt.toolkit.name=WLToolkit
      ''
      + ideaExtraVmopts;
  };

  ideaPlugins = builtins.attrValues {
    inherit (plugins.${system}.idea.${idea.version}) IdeaVIM;
  };

  variant = if colors.variant == "light" then "Light" else "Dark";
  version = lib.versions.majorMinor idea.version;
  options = "JetBrains/IntelliJIdea${version}/options";
in
lib.mkIf (work.enable) {
  home.packages = [
    (pkgs.jetbrains.plugins.addPlugins idea ideaPlugins)
  ];

  xdg.configFile."ideavim/ideavimrc".text = ''
    set clipboard+=unnamedplus,ideaput
    set ideajoin
  '';

  xdg.configFile."${options}/laf.xml".text = ''
    <application>
      <component name="LafManager" autodetect="true">
        <laf themeId="Experimental${variant}" />
      </component>
    </application>
  '';

  xdg.configFile."${options}/colors.scheme.xml".text = ''
    <application>
      <component name="EditorColorsManagerImpl">
        <global_color_scheme name="${variant}" />
      </component>
    </application>
  '';
}
