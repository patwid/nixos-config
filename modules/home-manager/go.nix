{ osConfig, ... }:
let
  inherit (osConfig) user;
in
{
  home.sessionVariables = {
    GOPATH = "/home/patwid/${user.name}/.local/share/go";

    GOPROXY = "direct";
    GOSUMDB = "off";
    GOTELEMETRY = "off";
    GOTOOLCHAIN = "local";
  };
}
