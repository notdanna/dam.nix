{ pkgs, ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "foot";
        font = "JetBrainsMono Nerd Font:size=9";
        font-size-adjustment = "1.0";
        box-drawings-uses-font-glyphs = "no";
        pad = "15x15";
        bold-text-in-bright = "no";
        word-delimiters = ",│`|:\"'()[]{}<>";
      };

      scrollback = {
        lines = 5000;
        multiplier = "3.0";
        indicator-position = "none";
      };

      url = {
        launch = "brave \${url}";
        osc8-underline = "always";
      };

      cursor = {
        style = "beam";
        unfocused-style = "hollow";
        blink = "yes";
      };

      colors-dark = {
        alpha = "0.93";
        # background = "1a1423";
        background = "000000";
        foreground = "e0def4";
        cursor = "ffffff ffffff";
        regular0 = "26233a";
        regular1 = "eb6f92";
        regular2 = "9ccfd8";
        regular3 = "f6c177";
        regular4 = "c4a7e7";
        regular5 = "908caa";
        regular6 = "ebbcba";
        regular7 = "e0def4";
        bright0 = "6e6a86";
        bright1 = "eb6f92";
        bright2 = "31748f";
        bright3 = "f6c177";
        bright4 = "b084f4";
        bright5 = "c4a7e7";
        bright6 = "ebbcba";
        bright7 = "e0def4";
      };

      tweak = {
        box-drawing-solid-shades = "no";
        grapheme-shaping = "yes";
        dim-amount = "1.0";
      };

      bell = {
        system = "yes";
        urgent = "yes";
        notify = "no";
        visual = "no";
        command = "${pkgs.pulseaudio}/bin/paplay ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/bell.oga";
      };
    };
  };
}