{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.qbittorrent = {
    image = "lscr.io/linuxserver/qbittorrent:latest";
    environment = {
      PUID = "1000";
      PGID = "1000";
      TZ = "America/Mexico_City";
      WEBUI_PORT = "8081";
    };
    volumes = [
      "/home/dam/qbittorrent/config:/config"
      "/home/dam/jellyfin/media/media:/downloads"
    ];
    ports = [
      "8081:8081"
      "6881:6881"
      "6881:6881/udp"
    ];
  };

  networking.firewall.allowedTCPPorts = [ 8081 6881 ];
  networking.firewall.allowedUDPPorts = [ 6881 ];
}
