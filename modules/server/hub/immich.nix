{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    # 1. Base de datos (Postgres con vectores para búsqueda por IA)
    immich-postgres = {
      image = "ghcr.io/immich-app/postgres:14-vectorchord0.4.3-pgvectors0.2.0";
      environment = {
        POSTGRES_PASSWORD = "20046969";
        POSTGRES_USER = "immich";
        POSTGRES_DB = "immich";
      };
      volumes = [ "/home/dam/immich/postgres:/var/lib/postgresql/data" ];
      extraOptions = [ "--network=immich-net" ];
    };

    # 2. Redis para la cola de tareas
    immich-redis = {
      image = "redis:6.2-alpine";
      extraOptions = [ "--network=immich-net" ];
    };

    # 3. Microservicio de Machine Learning (Reconocimiento facial/objetos)
    immich-machine-learning = {
      image = "ghcr.io/immich-app/immich-machine-learning:release";
      environment = {
        MACHINE_LEARNING_HOST = "0.0.0.0";
      };
      volumes = [ "/home/dam/immich/model-cache:/cache" ];
      extraOptions = [ "--network=immich-net" ];
    };

    # 4. Servidor principal de Immich
    immich-server = {
      image = "ghcr.io/immich-app/immich-server:release";
      dependsOn = [ "immich-postgres" "immich-redis" ];
      ports = [ "2283:2283" ]; # Puerto por defecto de Immich
      environment = {
        DB_HOSTNAME = "immich-postgres";
        DB_USERNAME = "immich";
        DB_PASSWORD = "20046969";
        DB_DATABASE_NAME = "immich";
        REDIS_HOSTNAME = "immich-redis";
        IMMICH_MACHINE_LEARNING_URL = "http://immich-machine-learning:3003";
      };
      volumes = [
        "/home/dam/immich/upload:/usr/src/app/upload"
        "/etc/localtime:/etc/localtime:ro"
      ];
      extraOptions = [ "--network=immich-net" ];
    };
  };
}
