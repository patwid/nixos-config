{ lib, config, pkgs }:
let
  inherit (config) colors;

  colorWithoutPrefix = color: lib.strings.removePrefix "#" color;
in
{
  overlay =
    (self: super: {
      wmenu = super.wmenu.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          ./keybindings.patch
          ./lineheight.patch
        ];
        buildInputs = (old.buildInputs or [ ]) ++ [
          pkgs.makeWrapper
        ];
        postInstall = old.postInstall or "" + ''
          wrapProgram $out/bin/wmenu \
            --add-flags "-N ${colorWithoutPrefix colors.darkestGrey}" \
            --add-flags "-n ${colorWithoutPrefix colors.lightGrey}" \
            --add-flags "-S ${colorWithoutPrefix colors.darkerGrey}" \
            --add-flags "-s ${colorWithoutPrefix colors.white}" \
            --add-flags "-f \"sans-serif 10\"" \
            --add-flags "-i"
        '';
      });
    });
}
