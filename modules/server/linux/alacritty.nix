{ pkgs, ... }:

{
  home.file.".config/alacritty/alacritty.toml".text = ''
    [font]
    size = 10.0

    [font.normal]
    family = "JetBrainsMono Nerd Font Mono"
    style = "Regular"

    [font.bold]
    style = "Bold"

    [font.italic]
    style = "Italic"

    [font.bold_italic]
    style = "Bold Italic"

    [window]
    opacity = 0.0
    decorations = "none"

    [window.dimensions]
    columns = 55
    lines = 15

    [window.padding]
    x = 10
    y = 10

    [cursor]
    vi_mode_style = "None"
    blink_interval = 750
    unfocused_hollow = true

    [cursor.style]
    shape = "Block"
    blinking = "On"

    [colors.primary]
    background = "#0B0A10"
    foreground = "#e4e1e9"
    bright_foreground = "#e7e7e7"
    dim_foreground = "#a5abb6"

    [colors.cursor]
    text = "#c7c5d0"
    cursor = "#e4e1e9"

    [colors.vi_mode_cursor]
    text = "#c7c5d0"
    cursor = "#e4e1e9"

    [colors.selection]
    text = "#2d2f42"
    background = "#c3c5dd"

    [colors.search.matches]
    foreground = "#0B0A10"
    background = "#CBA6F7"

    [colors.search.focused_match]
    foreground = "#0B0A10"
    background = "#CBA6F7"

    [colors.normal]
    black = "#4c4c4c"
    red = "#ac8a8c"
    green = "#CBA6F7"
    yellow = "#aca98a"
    blue = "#CBA6F7"
    magenta = "#ac8aac"
    cyan = "#CBA6F7"
    white = "#f0f0f0"

    [colors.bright]
    black = "#262626"
    red = "#c49ea0"
    green = "#CBA6F7"
    yellow = "#c4c19e"
    blue = "#a39ec4"
    magenta = "#c49ec4"
    cyan = "#9ec3c4"
    white = "#e7e7e7"

    [colors.dim]
    black = "#3a3a3a"
    red = "#94545d"
    green = "#4c7a5d"
    yellow = "#8f7b3f"
    blue = "#4c7a5d"
    magenta = "#94545d"
    cyan = "#4c7a5d"
    white = "#c0c0c0"

    [scrolling]
    history = 1000
    multiplier = 3

  '';

  home.packages = with pkgs; [
    alacritty
  ];
}