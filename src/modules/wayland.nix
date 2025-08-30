{ 
  "inputs": { 
    "nixpkgs": { 
      "url": "github:nixos/nixpkgs/nixos-unstable" 
    } 
  }, 
  "outputs": { 
    "nixosConfigurations": { 
      "mySystem": { 
        "config": { 
          "environment.systemPackages": [ 
            "wayland", 
            "wayland-utils", 
            "swaybg", 
            "sway", 
            "wl-clipboard" 
          ], 
          "services.xserver.enable": true, 
          "services.xserver.displayManager.startx.enable": true, 
          "services.xserver.windowManager.sway.enable": true 
        } 
      } 
    } 
  } 
}