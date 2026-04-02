{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.kavita = {
    image = "jvmilazz0/kavita:latest";
    ports = [ "5000:5000" ]; # Puerto por defecto de Kavita
    volumes = [
      "/home/dam/kavita/data:/kavita/config"      # Configuración y DB
      "/home/dam/kavita/manga:/manga:ro"          # Tu biblioteca de Manga
      "/home/dam/kavita/comics:/comics:ro"        # Tu biblioteca de Cómics
      "/home/dam/kavita/books:/books:ro"          # Libros/EPUBs
    ];
    environment = {
      TZ = "America/Mexico_City";
    };
  };
}
