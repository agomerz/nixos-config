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
            ./src/modules/vm-detect.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              # Pass a fixed isVM value instead of trying to access config.system
              home-manager.extraSpecialArgs = { isVM = true; };
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
            ./src/modules/vm-detect.nix
            home-manager.nixosModules.home-manager
            home-manager.nixosModules.home-manager
            {
              nixpkgs.config.allowUnfree = true;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            
              # this is what lets your home.nix see `isVM`
              home-manager.extraSpecialArgs = { inherit isVM; };
            
              home-manager.users.andy = {
                # let HM import it (don’t `import` yourself)
                imports = [ ./src/home-manager/home.nix ];
              };
            }
          ];
        };
      };
    };
}