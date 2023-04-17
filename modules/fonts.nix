{ pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    roboto-mono
  ];

  fonts.fontconfig = {
    defaultFonts = {
      emoji = [ "Noto Emoji" ];
      monospace = [ "Roboto Mono" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
    localConf = ''
      <selectfont>
        <rejectfont>
          <glob>${pkgs.dejavu_fonts}/*</glob>
          <glob>${pkgs.liberation_ttf}/*</glob>
          <glob>${pkgs.gyre-fonts}/*</glob>
          <glob>${pkgs.freefont_ttf}/*</glob>
          <glob>${pkgs.unifont}/*</glob>
        </rejectfont>
      </selectfont>
    '';
  };
}
