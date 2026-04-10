{ inputs, lib, ... }:
lib.composeManyExtensions [
  inputs.nixos-apple-silicon.overlays.default
  (final: prev: {
    uboot-asahi = prev.uboot-asahi.overrideAttrs (oldAttrs: {
      extraConfig = oldAttrs.extraConfig + ''
        CONFIG_VIDEO_LOGO=n
      '';
    });
  })
]
