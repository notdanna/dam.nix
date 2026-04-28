{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.hestia = {
    image = "hestia-core:latest";
    ports = [
      "8083:80"
    ];
    volumes = [
      "/home/dam/hestia/default.conf:/etc/nginx/conf.d/default.conf:ro"
    ];
  };
}
