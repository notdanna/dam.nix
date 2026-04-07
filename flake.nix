{
  description = "Configuración Multiplataforma";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = inputs@{ nixpkgs, nix-darwin, home-manager, zen-browser, sops-nix, nix-minecraft, ... }: {
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

    nixosConfigurations."damx" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/server/default.nix
        sops-nix.nixosModules.sops
        nix-minecraft.nixosModules.minecraft-servers
        { nixpkgs.overlays = [ nix-minecraft.overlay ]; }
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
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
              ./modules/server/zsh.nix
            ];
          };
        }
      ];
    };
  };
}
