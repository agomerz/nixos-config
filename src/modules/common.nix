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

  # Enable Hyprland (Wayland compositor)
  programs.hyprland.enable = true;
  
  # Keep X server for XWayland compatibility
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  
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
  
  # Optional: Create a systemd service for waybar if you want it to start automatically
  systemd.user.services.waybar = {
    description = "Waybar";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "on-failure";
    };
  };
}