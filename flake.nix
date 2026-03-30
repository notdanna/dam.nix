{
  description = "Configuración Multiplataforma";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    apple-silicon-support.url = "github:nix-community/nixos-apple-silicon";
    apple-silicon-support.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:youwen5/zen-browser-flake";
  };

  outputs = inputs@{ nixpkgs, nix-darwin, home-manager, apple-silicon-support, zen-browser, ... }: {
    darwinConfigurations."dam" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/darwin/default.nix
        home-manager.darwinModules.home-manager {
          home-manager.users.dam = {
            imports = [ ./home.nix ./modules/darwin/zsh.nix ];
          };
        }
      ];
    };

    nixosConfigurations."dam-linux" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        apple-silicon-support.nixosModules.apple-silicon-support
        ./hosts/linux/default.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.dam = {
            imports = [
              ./home.nix
              ./modules/linux/waybar.nix
              ./modules/linux/packages.nix
              ./modules/linux/foot.nix
              ./modules/linux/fuzzel.nix
              ./modules/linux/fastfetch.nix
              ./modules/linux/niri.nix
              ./modules/linux/dunst.nix
              ./modules/linux/zsh.nix
            ];
          };
        }
      ];
    };
  };
}
