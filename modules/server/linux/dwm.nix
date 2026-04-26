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

  home.packages = with pkgs; [
    xset
    xrandr
    feh
    dwmstatus
  ];
}