{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.slskd = {
    image = "slskd/slskd:latest";
    ports = [
      "5030:5030"
      "5032:5032"
    ];
    volumes = [
      "/home/dam/slskd/config:/app/config"
      "/home/dam/navidrome/music:/music:ro"
      "/home/dam/slskd/downloads:/app/downloads"
    ];
    environmentFiles = [ "/run/slskd.env" ];
    environment = {
      SLSKD_USERNAME = "dam";
      SLSKD_SLSK_USERNAME = "notdamx";
      SLSKD_REMOTE_CONFIGURATION = "true";
      SLSKD_SLSK_LISTEN_PORT = "5032";
      SLSKD_CONFIG = "/app/config/slskd.yml";
      SLSKD_SHARED_DIR = "[Music]/music";
    };
  };
}
