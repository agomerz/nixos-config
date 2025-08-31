{
  description = "NixOS configuration with Hyprland, Hyprpaper, Wayland, and Waybar";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  },
  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: {
      packages.default = with nixpkgs.legacyPackages.${system}; [
        # Add necessary packages here
      ];

      nixosConfigurations = {
        mySystem = nixpkgs.nixosSystem {
          system = system;
          modules = [
            ./src/configuration.nix
            ./src/modules/hyprland.nix
            ./src/modules/hyprpaper.nix
            ./src/modules/wayland.nix
            ./src/modules/waybar.nix
            ./src/hardware-configuration.nix
          ];
        };
      };
    });
}