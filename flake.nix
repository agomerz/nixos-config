{
  description = "NixOS configuration with Hyprland, Hyprpaper, Wayland, and Waybar";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, flake-utils, home-manager, ... }:
    flake-utils.lib.eachDefaultSystem (system: {
      packages.default = with nixpkgs.legacyPackages.${system}; [
        # Add necessary packages here
      ];
    }) // {
      nixosConfigurations = {
        # UTM/QEMU VM Configuration
        neutron-vm = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./src/hosts/vm/configuration.nix
            ./src/modules/common.nix
            # Add home-manager as a module
            home-manager.nixosModules.home-manager
            {
              # Home Manager configuration
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.andy = import ./src/home-manager/home.nix;
            }
          ];
        };
        
        # Bare Metal Configuration
        neutron-metal = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./src/hosts/metal/configuration.nix
            ./src/modules/common.nix
            # Add home-manager as a module
            home-manager.nixosModules.home-manager
            {
              # Home Manager configuration
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.andy = import ./src/home-manager/home.nix;
            }
          ];
        };
      };
    };
}