{ pkgs, ... }: {
  home.packages = with pkgs; [
    dunst
    libnotify
  ];

  xdg.configFile."dunst/dunstrc".source = ./dunst/dunstrc;
}
