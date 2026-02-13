{ lib, config, ... }:
let
  cfg = config.colors;

  black = "#151515";
  darkestGrey = "#252525";
  darkerGrey = "#353535";
  darkGrey = "#555555";
  lightGrey = "#b5b5b5";
  lighterGrey = "#d5d5d5";
  lightestGrey = "#e5e5e5";
  white = "#f5f5f5";
  red = "#ac4142";
  green = "#90a959";
  yellow = "#f4bf75";
  blue = "#6a9fb5";
  magenta = "#aa759f";
  cyan = "#75b5aa";

  light = {
    background = white;
    backgroundInactive = lightestGrey;
    backgroundActive = lighterGrey;
    foreground = darkerGrey;
    foregroundInactive = darkGrey;
  };

  dark = {
    background = black;
    backgroundInactive = darkestGrey;
    backgroundActive = darkerGrey;
    foreground = lighterGrey;
    foregroundInactive = lightGrey;
  };

  variant = if cfg.variant == "light" then light else dark;

  colorOption = _: lib.mkOption { type = lib.types.str; };
in
{
  options.colors =
    lib.genAttrs [
      "background"
      "backgroundInactive"
      "backgroundActive"
      "foreground"
      "foregroundInactive"
      "black"
      "darkestGrey"
      "darkerGrey"
      "darkGrey"
      "lightGrey"
      "lighterGrey"
      "lightestGrey"
      "white"
      "red"
      "green"
      "yellow"
      "blue"
      "magenta"
      "cyan"
    ] colorOption
    // {
      variant = lib.mkOption {
        type = lib.types.enum [
          "light"
          "dark"
        ];
        default = "light";
      };
    };

  config.colors = {
    inherit (variant)
      background
      backgroundInactive
      backgroundActive
      foreground
      foregroundInactive
      ;

    inherit
      black
      darkestGrey
      darkerGrey
      darkGrey
      lightGrey
      lighterGrey
      lightestGrey
      white
      red
      green
      yellow
      blue
      magenta
      cyan
      ;
  };
}
