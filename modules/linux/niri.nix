{ ... }: {
  xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;
  
  xdg.configFile."niri/autostart.sh" = {
    source = ./niri/autostart.sh;
    executable = true;
  };
}