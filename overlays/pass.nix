{
  overlay = (self: super: {
    pass = super.pass.override { dmenuSupport = false; };
  });
}
