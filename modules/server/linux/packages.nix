{ pkgs, ... }:

let
  dwmstatus = pkgs.writeShellScriptBin "dwmstatus" ''
    IFACE=$(${pkgs.iw}/bin/iw dev 2>/dev/null | awk '$1=="Interface"{print $2}' | head -1)
    PREV_RX=0
    PREV_TX=0

    while true; do
      # WiFi + velocidad
      SSID=$(${pkgs.wirelesstools}/bin/iwgetid -r 2>/dev/null)
      if [ -n "$SSID" ]; then
        RX=$(cat /sys/class/net/''${IFACE}/statistics/rx_bytes 2>/dev/null || echo 0)
        TX=$(cat /sys/class/net/''${IFACE}/statistics/tx_bytes 2>/dev/null || echo 0)
        RX_SPEED=$(( (RX - PREV_RX) / 1024 ))
        TX_SPEED=$(( (TX - PREV_TX) / 1024 ))
        PREV_RX=$RX
        PREV_TX=$TX
        WIFI="$SSID  ''${RX_SPEED}↓ ''${TX_SPEED}↑ KB/s"
      else
        WIFI="no wifi"
        PREV_RX=0
        PREV_TX=0
      fi

      # RAM en GB
      RAM=$(free -m | awk 'NR==2{printf "%.1fG/%.1fG", $3/1024, $2/1024}')

      # Disco (partición raíz)
      DISK=$(df -h / | awk 'NR==2{printf "%s/%s", $3, $2}')

      # Load como porcentaje de cores
      LOAD=$(awk -v cores=$(nproc) '{printf "%.0f%%", $1/cores*100}' /proc/loadavg)

      DATE=$(date '+%a %d %b  %H:%M')
      ${pkgs.xsetroot}/bin/xsetroot -name "$WIFI | $RAM | $DISK | $LOAD | $DATE"
      sleep 3
    done
  '';
in
{
  home.file.".xinitrc".text = ''
    # Desactivar pantalla de laptop y configurar monitor externo a 75Hz
    xrandr --output eDP --off --output HDMI-A-0 --mode 1920x1080 --rate 75.00 --primary --right-of eDP

    # Configurar apagado de pantalla tras 10 min de inactividad
    xset s 600 600
    xset dpms 600 600 600

    feh --bg-fill /home/dam/walls/main.jpg

    dwmstatus &

    exec dwm
  '';

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
    xset
    xrandr
    feh
    kitty
    dwmstatus
  ];
}
