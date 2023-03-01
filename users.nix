{ pkgs, args, ... }:
{
  users.users.${args.user} = {
    isNormalUser = true;
    description = "${args.user}";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [];
  };
}
