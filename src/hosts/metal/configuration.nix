{ config, pkgs, ... }:
{ 
  imports = [ 
      ./hardware-configuration.nix
  ]; 

  # Basic system settings 
  boot.loader.systemd-boot.enable = true; # Enable systemd-boot
  boot.loader.efi.canTouchEfiVariables = true; # Required for EFI systems
  networking.hostName = "neutron"; 
  time.timeZone = "UTC"; 

  # User configuration 
  users.users.andy = { 
    isNormalUser = true; 
    extraGroups = [ "wheel" "networkmanager" ]; 
  }; 

  networking.hostName = "neutron";
  hardware.nvidia = {
    modesetting.enable = true;
    prime = {
      offload.enable = true;
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];
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