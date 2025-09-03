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

  # Add a display manager to start Hyprland automatically
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;  # Use GDM which works well with Wayland
  services.xserver.displayManager.defaultSession = "hyprland";

  # Make sure XWayland is enabled
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable other necessary services
  security.polkit.enable = true;
  hardware.opengl.enable = true;

  # System packages (only include core packages here)
  environment.systemPackages = with pkgs; [ 
    wayland
    git
    vim
    xterm
    # Add these packages
    xwayland
    libinput
    wlr-randr
    glib # for gsettings
    adwaita-icon-theme
    swaylock
    swayidle

    # For rofi-wayland
    papirus-icon-theme  # Icon theme for Rofi
    libnotify  # For notifications
    xdg-utils  # For xdg-open
  ];
}