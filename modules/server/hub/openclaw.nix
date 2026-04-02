{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.openclaw = {
    image = "ghcr.io/openclaw/openclaw:main";
    ports = [ "3000:18789" ];
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "/:/host"
      "/home/dam/openclaw/data:/home/node/.openclaw"
    ];
    extraOptions = [
      "--add-host=host.docker.internal:host-gateway"
      "--group-add=131"
    ];
  };

  networking.firewall.allowedTCPPorts = [ 3000 ];
}
