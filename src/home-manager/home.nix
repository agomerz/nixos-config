{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
  ];

  # Ensure wallpaper directory exists
  home.file."wallpapers/default.jpg".source = ./wallpapers/default.jpg;

  home.username = "andy";
  home.homeDirectory = "/home/andy";
  
  home.packages = with pkgs; [
    # Additional packages for the user
    hyprpaper
    kitty
    neovim
    vim
    git
    ghostscript
    firefox
  ];

  # Home Manager needs a bit of information about you and the paths it should manage
  home.stateVersion = "25.11"; # Please set to the version you installed

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
