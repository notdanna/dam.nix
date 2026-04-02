{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.homepage = {
    image = "ghcr.io/gethomepage/homepage:latest";
    volumes = [
      "/home/dam/homepage/config:/app/config"
      "/var/run/docker.sock:/var/run/docker.sock:ro"
    ];
    extraOptions = [ "--network=host" ];
    environment = {
      HOMEPAGE_ALLOWED_HOSTS = "192.168.1.77,192.168.1.77:3000,100.100.95.111,100.100.95.111:3000,damx.kitty-larch.ts.net,damx.kitty-larch.ts.net:3000,hub.dikehub.site,localhost,127.0.0.1";
    };
  };
}
