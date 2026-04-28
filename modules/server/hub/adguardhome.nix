{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.adguardhome = {
    image = "adguard/adguardhome";
    ports = [
      "53:53/tcp"
      "53:53/udp"
      "3000:3000/tcp" # Interfaz de instalación inicial
      "8082:80/tcp"   # Panel de control (mapeado a 8080 para evitar conflictos)
      "443:443/tcp"
    ];
    volumes = [
      "/home/dam/adguard/workdir:/opt/adguardhome/work"
      "/home/dam/adguard/confdir:/opt/adguardhome/conf"
    ];
  };
}
