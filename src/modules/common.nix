{ config, pkgs, ... }:

{

  # Basic system settings
  boot.loader.systemd-boot.enable = true; # Enable systemd-boot
  boot.loader.efi.canTouchEfiVariables = true; # Required for EFI systems
  networking.hostName = "neutron"; # Set your hostname
  time.timeZone = "America/New_York"; # Set your timezone

  # Enable SSH for remote access
  services.openssh.enable = true;

  # User configuration 
  users.users.andy = { 
    isNormalUser = true; 
    extraGroups = [ "wheel" "networkmanager" ]; 
  }; 

  # Enable sudo for users in the wheel group
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # Enable necessary services 
  services.xserver.enable = true; 
  services.xserver.displayManager.startx.enable = true; 
  services.xserver.windowManager.hyprland.enable = true; 
  services.wayland.enable = true; 
  services.waybar.enable = true; 

  # System packages 
  environment.systemPackages = with pkgs; [ 
    hyprland 
    hyprpaper 
    wayland 
    waybar 
    vim 
    git
    ghostscript 
    neovim
    kitty
  ]; 
}