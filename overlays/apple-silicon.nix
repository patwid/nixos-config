{ inputs, lib, ... }:
lib.composeManyExtensions [
  inputs.nixos-apple-silicon.overlays.default
  (final: prev: {
    m1n1 = (prev.m1n1.override { customLogo = null; }).overrideAttrs (oldAttrs: {
      postPatch = (oldAttrs.postPatch or "") + ''
        # replace built-in Asahi boot logos with blank (black) images
        for size in 48 128 256; do
          magick -size ''${size}x''${size} xc:black -depth 8 rgba:data/bootlogo_''${size}.bin
        done
      '';
    });
    uboot-asahi = prev.uboot-asahi.overrideAttrs (oldAttrs: {
      extraConfig = oldAttrs.extraConfig + ''
        CONFIG_VIDEO_LOGO=n
      '';
    });
  })
]
