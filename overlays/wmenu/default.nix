{ lib, config, pkgs }:
let
  inherit (config) colors;
in
{
  overlay =
    (self: super: {
      wmenu = super.wmenu.overrideAttrs (old: {
        patches = (old.patches or []) ++ [
          ./keybindings.patch
        ];
        buildInputs = (old.buildInputs or []) ++ [
          pkgs.makeWrapper
        ];
        postInstall = old.postInstall or "" + ''
          wrapProgram $out/bin/wmenu \
            --add-flags "-N ${lib.strings.removePrefix "#" colors.darkestGrey}" \
            --add-flags "-n ${lib.strings.removePrefix "#" colors.lightGrey}" \
            --add-flags "-S ${lib.strings.removePrefix "#" colors.darkerGrey}" \
            --add-flags "-s ${lib.strings.removePrefix "#" colors.white}" \
        '';
      });
    });
}
