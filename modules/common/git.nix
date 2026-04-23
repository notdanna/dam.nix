{ pkgs, ... }: {
  programs.git = {
    enable = true;
    settings = {
      user.name = "notdanna";
      user.email = "afrancor1900@alumno.ipn.mx";
      signing.format = "openpgp";
    };
  };
}
