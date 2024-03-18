{ lib, config, pkgs, ... }:
let
  inherit (config) colors;
in
self: super: {
  wmenu = super.wmenu.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      ./lineheight.patch
    ];

    buildInputs = (old.buildInputs or [ ]) ++ [
      pkgs.makeWrapper
    ];

    postInstall = (old.postInstall or "") + ''
      wrapProgram $out/bin/wmenu \
        --add-flags "-N ${lib.colors.withoutPrefix colors.background}" \
        --add-flags "-n ${lib.colors.withoutPrefix colors.foreground}" \
        --add-flags "-S ${lib.colors.withoutPrefix colors.backgroundActive}" \
        --add-flags "-s ${lib.colors.withoutPrefix colors.foreground}" \
        --add-flags "-i"
    '';
  });
}
