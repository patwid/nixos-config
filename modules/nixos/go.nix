{ config, ... }:
let
  inherit (config) user;
in
{
  environment.sessionVariables = {
    GOPATH = "/home/${user.name}/.local/share/go";

    GOPROXY = "direct";
    GOSUMDB = "off";
    GOTELEMETRY = "off";
    GOTOOLCHAIN = "local";
  };
}
