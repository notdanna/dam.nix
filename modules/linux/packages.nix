{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    spotify-player
    obsidian
    vesktop
    swaylock
    inputs.zen-browser.packages."${pkgs.system}".default

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
