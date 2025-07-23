{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
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
          <pattern>
            <patelt name="family">
              <string>Liberation Sans</string>
            </patelt>
          </pattern>
        </rejectfont>
        <rejectfont>
          <pattern>
            <patelt name="family">
              <string>Liberation Serif</string>
            </patelt>
          </pattern>
        </rejectfont>
        <rejectfont>
          <pattern>
            <patelt name="family">
              <string>Liberation Mono</string>
            </patelt>
          </pattern>
        </rejectfont>
        <rejectfont>
          <pattern>
            <patelt name="family">
              <string>DejaVu Sans</string>
            </patelt>
          </pattern>
        </rejectfont>
        <rejectfont>
          <pattern>
            <patelt name="family">
              <string>DejaVu Serif</string>
            </patelt>
          </pattern>
        </rejectfont>
        <rejectfont>
          <pattern>
            <patelt name="family">
              <string>DejaVu Sans Mono</string>
            </patelt>
          </pattern>
        </rejectfont>
        <rejectfont>
          <pattern>
            <patelt name="family">
              <string>TeX Gyre Heros</string>
            </patelt>
          </pattern>
        </rejectfont>
        <rejectfont>
          <pattern>
            <patelt name="family">
              <string>Free Sans</string>
            </patelt>
          </pattern>
        </rejectfont>
        <rejectfont>
          <pattern>
            <patelt name="family">
              <string>Free Serif</string>
            </patelt>
          </pattern>
        </rejectfont>
        <rejectfont>
          <pattern>
            <patelt name="family">
              <string>Free Mono</string>
            </patelt>
          </pattern>
        </rejectfont>
      </selectfont>
    '';
  };
}
