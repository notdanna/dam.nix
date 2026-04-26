{ config, lib, pkgs, inputs, ... }:

let
  myDwm = pkgs.dwm.overrideAttrs (oldAttrs: {
    src = "${inputs.dawm-c}/dots/dwm";
    preBuild = "make clean";
    makeFlags = [ "PREFIX=$(out)" ];
    buildInputs = with pkgs; [ 
      libinput 
      libX11 
      libXft 
      libXinerama 
    ];
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.pkg-config ];
  });

  myDmenu = pkgs.dmenu.overrideAttrs (oldAttrs: {
    src = "${inputs.dawm-c}/dots/dmenu";
    preBuild = "make clean";
    makeFlags = [ "PREFIX=$(out)" ];
    buildInputs = with pkgs; [
      libX11
      libXft
      libXinerama
    ];
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.pkg-config ];
  });

in
{
  services.libinput.enable = true;
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    xkb.layout = "latam";
    windowManager.dwm = {
      enable = true;
      package = myDwm;
    };
  };

  environment.systemPackages = with pkgs; [
    myDmenu
    flameshot
    xcolor
    pamixer
    brightnessctl
  ];
}