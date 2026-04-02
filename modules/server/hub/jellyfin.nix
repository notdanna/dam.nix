{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.jellyfin = {
    image = "jellyfin/jellyfin:latest";
    ports = [ "8096:8096" ];
    volumes = [
      "/home/dam/jellyfin/config:/config"
      "/home/dam/jellyfin/cache:/cache"
      "/home/dam/jellyfin/media/media/:/media"
      # --- INDISPENSABLE PARA NIXOS ---
      "/run/opengl-driver:/run/opengl-driver:ro"
      "/nix/store:/nix/store:ro" 
      "/run/opengl-driver/etc/OpenCL/vendors:/etc/OpenCL/vendors:ro"
    ];
    environment = {
      LIBVA_DRIVER_NAME = "radeonsi";
      # Ayuda a FFmpeg a encontrar las librerías de cómputo
      LD_LIBRARY_PATH = "/run/opengl-driver/lib";
      JELLYFIN_FFMPEG_OPT_OPENCL_DEVICE = "0.0";
      JELLYFIN_VideoFilters__AllowHardwareFilters = "true";
    };

    extraOptions = [
      "--device=/dev/dri/renderD128:/dev/dri/renderD128"
      "--device=/dev/dri/card1:/dev/dri/card1"
      "--device=/dev/kfd:/dev/kfd"
      "--group-add=26"
      "--group-add=303"
    ];
  };
}
