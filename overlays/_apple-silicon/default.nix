final: prev:
{
  uboot-asahi = prev.uboot-asahi.overrideAttrs (oldAttrs: {
    extraConfig = oldAttrs.extraConfig + ''
      CONFIG_VIDEO_LOGO=n
    '';
  });
}
