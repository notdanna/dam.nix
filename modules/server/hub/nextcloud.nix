{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      nextcloud-db = {
        image = "mariadb:10.6";
        environmentFiles = [ "/run/nextcloud.env" ];
        environment = {
          MYSQL_DATABASE = "nextcloud";
          MYSQL_USER = "nextcloud";
        };
        volumes = [ "/home/dam/nextcloud/db:/var/lib/mysql" ];
        extraOptions = [ "--network=nextcloud-net" ];
      };

      nextcloud-app = {
        image = "nextcloud:latest";
        dependsOn = [ "nextcloud-db" ];
        ports = [ "8080:80" ];
        environmentFiles = [ "/run/nextcloud.env" ];
        environment = {
          MYSQL_DATABASE = "nextcloud";
          MYSQL_USER = "nextcloud";
          MYSQL_HOST = "nextcloud-db";
        };
        volumes = [ 
        "/home/dam/nextcloud/data:/var/www/html" 
        "/home/dam/navidrome/music:/navidrome_music:ro"
        "/home/dam/slskd/downloads:/slskd_downloads:ro"
        "/home/dam/dataset:/dataset_tt:ro"
        ];
        extraOptions = [ "--network=nextcloud-net" ];
      };
    };
  };
}
