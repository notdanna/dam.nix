{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.navidrome = {
    image = "deluan/navidrome:latest";
    ports = [ "4533:4533" ];
    environment = {
      ND_SCANSCHEDULE = "1h";
      ND_LOGLEVEL = "info";
      ND_SESSIONTIMEOUT = "24h";
      ND_BASEURL = "";
      ND_ENABLETRANSCODINGCONFIG = "true";
      ND_TRANSCODINGCACHESIZE = "1GB";
    };
    volumes = [
      "/home/dam/navidrome/data:/data"
      "/home/dam/navidrome/music/music:/music/me:ro"
      "/home/dam/navidrome/music/maybe:/music/maybe:ro"
      "/home/dam/navidrome/music/mimimi:/music/mimimi:ro"
      "/home/dam/navidrome/music/emo:/music/emo:ro"
      "/home/dam/slskd/downloads:/music/slskd:ro"
    ];
  };
}
