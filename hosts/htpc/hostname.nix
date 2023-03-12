{ lib, ... }:
let
  hostname = baseNameOf (toString ./.);
in
{
  networking.hostName = "${hostname}";
}
