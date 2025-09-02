{ config, pkgs, ... }:

{
  # Basic system settings
  boot.loader.systemd-boot.enable = true; # Enable systemd-boot
  boot.loader.efi.canTouchEfiVariables = true; # Required for EFI systems
  networking.hostName = "neutron"; # Set your hostname
  time.timeZone = "America/New_York"; # Set your timezone
  
  # Set the state version
  system.stateVersion = "25.11"; # Set to the NixOS version you're starting with

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

  # Keep X server for XWayland compatibility
  services.xserver.enable = true;
  
  # System packages (only include core packages here)
  environment.systemPackages = with pkgs; [ 
    wayland
    git
    vim
  ];
}