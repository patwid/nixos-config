{ lib, config, ... }:
let
  cfg = config.colors;

  black = "#181818";
  darkestGrey = "#282828";
  darkerGrey = "#383838";
  darkGrey = "#585858";
  lightGrey = "#b8b8b8";
  lighterGrey = "#d8d8d8";
  lightestGrey = "#e8e8e8";
  white = "#f8f8f8";
  red = "#ab4642";
  green = "#a1b56c";
  yellow = "#f7ca88";
  blue = "#7cafc2";
  magenta = "#ba8baf";
  cyan = "#86c1b9";
in
{
  options.colors = {
    variant = lib.mkOption {
      type = lib.types.enum [ "light" "dark" ];
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
    foregroundAlt = lib.mkOption {
      type = lib.types.str;
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
    variant = "light";

    background = if cfg.variant == "light" then white else black;
    backgroundInactive = if cfg.variant == "light" then lightestGrey else darkestGrey;
    backgroundActive = if cfg.variant == "light" then lighterGrey else darkerGrey;

    foreground = if cfg.variant == "light" then darkerGrey else lighterGrey;
    foregroundAlt = if cfg.variant == "light" then black else white;

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
      cyan;
  };
}
