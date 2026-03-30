{ pkgs, ... }: {
  home.packages = with pkgs; [
    spotify-player
    obsidian
    vesktop
    swaylock

    swaybg
    playerctl
    (vscode.override {
      commandLineArgs = [
        "--ozone-platform=wayland"
        "--disable-gpu-sandbox"
      ];
    })
  ];
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
}