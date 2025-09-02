{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    style = ''
      * {
        font-family: "JetBrains Mono", "Font Awesome 6 Free";
        font-size: 13px;
      }
      
      window#waybar {
        background: rgba(21, 18, 27, 0.8);
        color: #ffffff;
      }
      
      #workspaces button {
        padding: 0 5px;
        background: transparent;
        color: #ffffff;
        border-bottom: 3px solid transparent;
      }
      
      #workspaces button.focused {
        background: #64727D;
        border-bottom: 3px solid #ffffff;
      }
      
      #clock, #battery, #cpu, #memory, #network, #pulseaudio, #tray, #mode {
        padding: 0 10px;
        margin: 0 5px;
      }
      
      #clock {
        background-color: #64727D;
      }
      
      #battery {
        background-color: #ffffff;
        color: black;
      }
      
      #battery.charging {
        color: white;
        background-color: #26A65B;
      }
      
      @keyframes blink {
        to {
          background-color: #ffffff;
          color: black;
        }
      }
      
      #battery.warning:not(.charging) {
        background: #f53c3c;
        color: white;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
    '';
    
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "cpu" "memory" "network" "pulseaudio" "battery" "clock" "tray" ];
        
        "hyprland/workspaces" = {
          format = "{name}: {icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            urgent = "";
            active = "";
            default = "";
          };
        };
        
        cpu = {
          format = "CPU {usage}%";
          tooltip = false;
        };
        
        memory = {
          format = "MEM {}%";
        };
        
        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%Y-%m-%d}";
          tooltip-format = "{:%Y-%m-%d | %H:%M}";
        };
        
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = ["" "" "" "" ""];
        };
        
        network = {
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = " {ifname}: {ipaddr}/{cidr}";
          format-linked = " {ifname} (No IP)";
          format-disconnected = "⚠ Disconnected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        
        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}% ";
          format-bluetooth-muted = " {icon} ";
          format-muted = " ";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };
        
        tray = {
          icon-size = 21;
          spacing = 10;
        };
      };
    };
  };
}
