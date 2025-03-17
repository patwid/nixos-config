{ lib, config, ... }:
let
  cfg = config.colors;

  black = "#101010";
  darkestGrey = "#202020";
  darkerGrey = "#303030";
  darkGrey = "#505050";
  lightGrey = "#b0b0b0";
  lighterGrey = "#d0d0d0";
  lightestGrey = "#e0e0e0";
  white = "#f0f0f0";
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
  inverse = if cfg.variant == "light" then dark else light;
in
{
  options.colors = {
    variant = lib.mkOption {
      type = lib.types.enum [
        "light"
        "dark"
      ];
      default = "light";
    };

    background = lib.mkOption {
      type = lib.types.str;
    };
    backgroundInactive = lib.mkOption {
      type = lib.types.str;
    };
    backgroundActive = lib.mkOption {
      type = lib.types.str;
    };
    foreground = lib.mkOption {
      type = lib.types.str;
    };
    foregroundInactive = lib.mkOption {
      type = lib.types.str;
    };

    inverse = {
      background = lib.mkOption {
        type = lib.types.str;
      };
      backgroundInactive = lib.mkOption {
        type = lib.types.str;
      };
      backgroundActive = lib.mkOption {
        type = lib.types.str;
      };
      foreground = lib.mkOption {
        type = lib.types.str;
      };
      foregroundInactive = lib.mkOption {
        type = lib.types.str;
      };
    };

    black = lib.mkOption {
      type = lib.types.str;
    };
    darkestGrey = lib.mkOption {
      type = lib.types.str;
    };
    darkerGrey = lib.mkOption {
      type = lib.types.str;
    };
    darkGrey = lib.mkOption {
      type = lib.types.str;
    };
    lightGrey = lib.mkOption {
      type = lib.types.str;
    };
    lighterGrey = lib.mkOption {
      type = lib.types.str;
    };
    lightestGrey = lib.mkOption {
      type = lib.types.str;
    };
    white = lib.mkOption {
      type = lib.types.str;
    };
    red = lib.mkOption {
      type = lib.types.str;
    };
    green = lib.mkOption {
      type = lib.types.str;
    };
    yellow = lib.mkOption {
      type = lib.types.str;
    };
    blue = lib.mkOption {
      type = lib.types.str;
    };
    magenta = lib.mkOption {
      type = lib.types.str;
    };
    cyan = lib.mkOption {
      type = lib.types.str;
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
      inverse
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
