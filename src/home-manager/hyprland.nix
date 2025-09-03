{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true; # Important for proper systemd integration
    xwayland.enable = true; # Enable XWayland support
    settings = {
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          new_optimizations = true;
        };
      };

      drop_shadow = true;
      shadow_range = 4;
      shadow_render_power = 3;
      "col.shadow" = "rgba(1a1a1aee)";

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0.0; # -1.0 - 1.0, 0 means no modification
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      gestures = {
        workspace_swipe = false;
      };

      # Example window rules
      windowrulev2 = "float,class:^(pavucontrol)$";

      # Example binds
      bind = [
        "SUPER,Return,exec,kitty"
        "SUPER,Q,killactive,"
        "SUPER,M,exit,"
        "SUPER,E,exec,dolphin"
        "SUPER,Space,togglefloating,"
        "SUPER,R,exec,wofi --show drun"
        "SUPER,P,pseudo,"
        "SUPER,F,fullscreen,1"

        # Move focus with SUPER + arrow keys
        "SUPER,left,movefocus,l"
        "SUPER,right,movefocus,r"
        "SUPER,up,movefocus,u"
        "SUPER,down,movefocus,d"

        # Switch workspaces
        "SUPER,1,workspace,1"
        "SUPER,2,workspace,2"
        "SUPER,3,workspace,3"
        "SUPER,4,workspace,4"
        "SUPER,5,workspace,5"
        "SUPER,6,workspace,6"
        "SUPER,7,workspace,7"
        "SUPER,8,workspace,8"
        "SUPER,9,workspace,9"
        "SUPER,0,workspace,10"

        # Move active window to a workspace
        "SUPER_SHIFT,1,movetoworkspace,1"
        "SUPER_SHIFT,2,movetoworkspace,2"
        "SUPER_SHIFT,3,movetoworkspace,3"
        "SUPER_SHIFT,4,movetoworkspace,4"
        "SUPER_SHIFT,5,movetoworkspace,5"
        "SUPER_SHIFT,6,movetoworkspace,6"
        "SUPER_SHIFT,7,movetoworkspace,7"
        "SUPER_SHIFT,8,movetoworkspace,8"
        "SUPER_SHIFT,9,movetoworkspace,9"
        "SUPER_SHIFT,0,movetoworkspace,10"
      ];
    };

    # Make sure Hyprland starts some essential components
    extraConfig = ''
      # Monitor configuration for VM
      monitor=,preferred,auto,1

      # Execute your apps at launch
      exec-once = waybar
      exec-once = hyprpaper
    '';
  };

  # Add hyprpaper configuration
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ${config.home.homeDirectory}/wallpapers/default.jpg
    wallpaper = ,${config.home.homeDirectory}/wallpapers/default.jpg
    ipc = off
  '';
}
