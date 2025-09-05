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

  # Add rofi-wayland
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "xterm";  # Use xterm since it works in VM
    theme = "Arc-Dark";
    font = "JetBrains Mono 12";
    extraConfig = {
      modi = "drun,run,window,ssh";
      icon-theme = "Papirus";
      show-icons = true;
      drun-display-format = "{name}";
      disable-history = false;
      sidebar-mode = true;
    };
  };

  home.file.".bashrc".text = ''
    export EDITOR="nvim"
    ns-rebuild (){
      pushd ~/.config/nixos/nixos-config
      sudo nixos-rebuild switch --flake .#neutron-metal
      popd
    }
    alias vim="nvim"
    fastfetch
  '';

  # Add this to your existing home.nix configuration
  # home.file.".config/rofi/config.rasi".text = ''
  #   configuration {
  #     modi: "drun,run,window,ssh";
  #     font: "JetBrains Mono 12";
  #     terminal: "xterm";
  #     drun-display-format: "{name}";
  #     location: 0;
  #     disable-history: false;
  #     hide-scrollbar: true;
  #     display-drun: " Apps ";
  #     display-run: " Run ";
  #     display-window: " Windows ";
  #     display-ssh: " SSH ";
  #     sidebar-mode: true;
  #   }

  #   @theme "Arc-Dark"

  #   element-text, element-icon {
  #     background-color: inherit;
  #     text-color:       inherit;
  #   }

  #   window {
  #     height: 360px;
  #     border: 3px;
  #     border-color: @border-col;
  #     background-color: @bg-col;
  #     border-radius: 12px;
  #   }

  #   mainbox {
  #     background-color: @bg-col;
  #   }

  #   inputbar {
  #     children: [prompt,entry];
  #     background-color: @bg-col;
  #     border-radius: 5px;
  #     padding: 2px;
  #   }
  # '';

  # Home Manager needs a bit of information about you and the paths it should manage
  home.stateVersion = "25.11"; # Please set to the version you installed

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
