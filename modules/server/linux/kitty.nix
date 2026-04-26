{ pkgs, ... }:

{
  home.file.".config/kitty/kitty.conf".text = ''
    font_family      JetBrainsMono Nerd Font Mono
    bold_font        auto
    italic_font      auto
    bold_italic_font auto
    font_size        10.0

    background_opacity 0
    linux_display_server x11

    initial_window_width  55c
    initial_window_height 15c
    window_padding_width  10
    confirm_os_window_close 0

    cursor            #e4e1e9
    cursor_text_color #c7c5d0
    foreground        #e4e1e9
    background        #0B0A10
    selection_foreground #2d2f42
    selection_background #c3c5dd
    url_color         #CBA6F7

    # black
    color0  #4c4c4c
    color8  #262626
    # red
    color1  #ac8a8c
    color9  #c49ea0
    # green
    color2  #CBA6F7
    color10 #CBA6F7
    # yellow
    color3  #aca98a
    color11 #c4c19e
    # blue
    color4  #CBA6F7
    color12 #a39ec4
    # magenta
    color5  #ac8aac
    color13 #c49ec4
    # cyan
    color6  #CBA6F7
    color14 #9ec3c4
    # white
    color7  #f0f0f0
    color15 #e7e7e7

    scrollback_lines 1000
    map kitty_mod+t new_tab_with_cwd
  '';

  home.packages = with pkgs; [
    kitty
  ];
}