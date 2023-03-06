{
  imports = [
    ../../modules/user.nix
  ];

  user = {
    name = "patwid";
    email = "patrick.widmer@ergon.ch";
    group = "ergon";
    uid = 1795;
    gid = 1111;
  };
}
