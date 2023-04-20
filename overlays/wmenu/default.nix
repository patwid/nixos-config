{
  overlay =
    (self: super: {
      wmenu = super.wmenu.overrideAttrs (old: {
        patches = (old.patches or []) ++ [
          ./keybindings.patch
        ];
      });
    });
}
