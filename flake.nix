{
  description = "NixOS configuration with Hyprland, Hyprpaper, Wayland, and Waybar";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: {
      packages.default = with nixpkgs.legacyPackages.${system}; [
        # Add necessary packages here
      ];
    }) // {
      nixosConfigurations = {
        neutron = nixpkgs.lib.nixosSystem { # Match the hostname here
          system = "x86_64-linux";
          modules = [
            ./src/configuration.nix
          ];
        };
      };
    };
}