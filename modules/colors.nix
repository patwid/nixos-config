{ lib, ... }:
{
  options.colors = {
    black = lib.mkOption {
      type = lib.types.str;
      default = "#181818";
    };
    darkestGrey = lib.mkOption {
      type = lib.types.str;
      default = "#282828";
    };
    darkerGrey = lib.mkOption {
      type = lib.types.str;
      default = "#383838";
    };
    darkGrey = lib.mkOption {
      type = lib.types.str;
      default = "#585858";
    };
    lightGrey = lib.mkOption {
      type = lib.types.str;
      default = "#b8b8b8";
    };
    lighterGrey = lib.mkOption {
      type = lib.types.str;
      default = "#d8d8d8";
    };
    lightestGrey = lib.mkOption {
      type = lib.types.str;
      default = "#e8e8e8";
    };
    white = lib.mkOption {
      type = lib.types.str;
      default = "#f8f8f8";
    };
    red = lib.mkOption {
      type = lib.types.str;
      default = "#ab4642";
    };
    green = lib.mkOption {
      type = lib.types.str;
      default = "#a1b56c";
    };
    yellow = lib.mkOption {
      type = lib.types.str;
      default = "#f7ca88";
    };
    blue = lib.mkOption {
      type = lib.types.str;
      default = "#7cafc2";
    };
    magenta = lib.mkOption {
      type = lib.types.str;
      default = "#ba8baf";
    };
    cyan = lib.mkOption {
      type = lib.types.str;
      default = "#86c1b9";
    };
  };
}
