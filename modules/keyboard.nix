{ lib, ... }:
{
  options.keyboard.repeat = {
    rate = lib.mkOption {
      type = lib.types.int;
    };
    delay = lib.mkOption {
      type = lib.types.int;
    };
  };

  config = {
    keyboard.repeat = {
      rate = 30;
      delay = 200;
    };
  };
}
