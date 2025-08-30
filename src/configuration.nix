{ 
  imports = [ 
    ./hardware-configuration.nix, 
    ./modules/hyprland.nix, 
    ./modules/hyprpaper.nix, 
    ./modules/wayland.nix, 
    ./modules/waybar.nix 
  ]; 

  # Basic system settings 
  system = "x86_64-linux"; 
  boot.loader.systemd-boot.enable = true; # Enable systemd-boot
  boot.loader.efi.canTouchEfiVariables = true; # Required for EFI systems
  networking.hostName = "neutron"; 
  time.timeZone = "UTC"; 

  # User configuration 
  users.users.andy = { 
    isNormalUser = true; 
    extraGroups = [ "wheel" "networkmanager" ]; 
  }; 

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
  ]; 
}