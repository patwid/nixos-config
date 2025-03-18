{
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  inherit (osConfig) colors work ideaExtraVmopts;

  idea-ultimate = pkgs.jetbrains.idea-ultimate.override {
    vmopts =
      ''
        -Dawt.toolkit.name=WLToolkit
      ''
      + ideaExtraVmopts;
  };

  variant = if colors.variant == "light" then "Light" else "Dark";
  version = lib.versions.majorMinor idea-ultimate.version;
  options = "JetBrains/IntelliJIdea${version}/options";
in
lib.mkIf (work.enable) {
  home.packages = [
    (pkgs.jetbrains.plugins.addPlugins idea-ultimate [ "ideavim" ])
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
