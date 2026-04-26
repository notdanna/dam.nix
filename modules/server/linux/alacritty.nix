{ pkgs, ... }:

{
  home.file.".config/alacritty/alacritty.yml".text = ''
    font:
      normal:
        family: JetBrainsMono Nerd Font Mono
        style: Regular
      bold:
        style: Bold
      italic:
        style: Italic
      bold_italic:
        style: Bold Italic
      size: 10.0

    window:
      opacity: 0.0
      dimensions:
        columns: 55
        lines: 15
      padding:
        x: 10
        y: 10
      decorations: none

    cursor:
      style:
        shape: Block
        blinking: On
      vi_mode_style: None
      blink_interval: 750
      unfocused_hollow: true

    colors:
      primary:
        background: '0x0B0A10'
        foreground: '0xe4e1e9'
        bright_foreground: '0xe7e7e7'
        dim_foreground: '0xa5abb6'
      cursor:
        text: '0xc7c5d0'
        cursor: '0xe4e1e9'
      vi_mode_cursor:
        text: '0xc7c5d0'
        cursor: '0xe4e1e9'
      selection:
        text: '0x2d2f42'
        background: '0xc3c5dd'
      search:
        matches:
          foreground: '0x0B0A10'
          background: '0xCBA6F7'
        focused_match:
          foreground: '0x0B0A10'
          background: '0xCBA6F7'
      normal:
        black: '0x4c4c4c'
        red: '0xac8a8c'
        green: '0xCBA6F7'
        yellow: '0xaca98a'
        blue: '0xCBA6F7'
        magenta: '0xac8aac'
        cyan: '0xCBA6F7'
        white: '0xf0f0f0'
      bright:
        black: '0x262626'
        red: '0xc49ea0'
        green: '0xCBA6F7'
        yellow: '0xc4c19e'
        blue: '0xa39ec4'
        magenta: '0xc49ec4'
        cyan: '0x9ec3c4'
        white: '0xe7e7e7'
      dim:
        black: '0x3a3a3a'
        red: '0x94545d'
        green: '0x4c7a5d'
        yellow: '0x8f7b3f'
        blue: '0x4c7a5d'
        magenta: '0x94545d'
        cyan: '0x4c7a5d'
        white: '0xc0c0c0'

    scrolling:
      history: 1000
      multiplier: 3

    keyboard:
      bindings:
        - { key: T, mods: Control|Shift, action: NewTab }
  '';

  home.packages = with pkgs; [
    alacritty
  ];
}