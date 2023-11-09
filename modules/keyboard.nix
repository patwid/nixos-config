{ lib, ... }:
{
  options.keyboard.repeat = {
    rate = lib.mkOption {
      type = lib.types.int;
      default = 30;
    };
    delay = lib.mkOption {
      type = lib.types.int;
      default = 200;
    };
  };
}
