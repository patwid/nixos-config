{ lib', config, pkgs, ... }:
let
  inherit (config) colors;
in
self: super: {
  wmenu = super.wmenu.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      ./keybindings.patch
      ./lineheight.patch
    ];
    buildInputs = (old.buildInputs or [ ]) ++ [
      pkgs.makeWrapper
    ];
    postInstall = (old.postInstall or "") + ''
      wrapProgram $out/bin/wmenu \
        --add-flags "-N ${lib'.colors.withoutPrefix colors.black}" \
        --add-flags "-n ${lib'.colors.withoutPrefix colors.lightGrey}" \
        --add-flags "-S ${lib'.colors.withoutPrefix colors.darkerGrey}" \
        --add-flags "-s ${lib'.colors.withoutPrefix colors.white}" \
        --add-flags "-i"
    '';
  });
}
