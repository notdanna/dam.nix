{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.glances = {
    image = "nicolargo/glances:latest-full";
    ports = [ "61208:61208" ];
    environment = {
      # -w: Webserver
      # -t 10: Actualiza cada 10 segundos
      # --disable-plugin: Desactiva todo lo que Hestia no muestra
      GLANCES_OPT = "-w -t 10 --disable-plugin network,diskio,fs,ip,connections,raid,smart,gpu,ports,irq,wifi,folders";
    };
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock:ro"
      "/:/host:ro"
    ];
    extraOptions = [
      "--pid=host"
      "--privileged"
      "--cpus=0.1" # Te sugiero subirlo a 0.1 (10%) para que no se congele al procesar
      "--memory=128m"
    ];
  };
}
