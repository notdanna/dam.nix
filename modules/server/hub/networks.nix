{ pkgs, ... }: {
  systemd.services.docker-networks = {
    description = "Create Docker networks";
    after    = [ "docker.service" ];
    requires = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];
    before   = [
      "docker-nextcloud-db.service"
      "docker-immich-postgres.service"
      "docker-immich-redis.service"
    ];
    serviceConfig = {
      Type            = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "docker-create-networks" ''
        ${pkgs.docker}/bin/docker network inspect nextcloud-net >/dev/null 2>&1 || \
          ${pkgs.docker}/bin/docker network create nextcloud-net
        ${pkgs.docker}/bin/docker network inspect immich-net >/dev/null 2>&1 || \
          ${pkgs.docker}/bin/docker network create immich-net
      '';
    };
  };
}

