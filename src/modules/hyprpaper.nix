{
  "description": "Hyprpaper configuration for managing wallpapers and backgrounds.",
  "options": {
    "enable": {
      "type": "bool",
      "default": true,
      "description": "Enable Hyprpaper."
    },
    "wallpapers": {
      "type": "list",
      "default": [],
      "description": "List of wallpapers to be used by Hyprpaper."
    },
    "timeout": {
      "type": "int",
      "default": 30,
      "description": "Time in seconds between wallpaper changes."
    }
  },
  "config": {
    "environment.systemPackages": [
      "hyprpaper"
    ],
    "services.hyprpaper": {
      "enable": true,
      "wallpapers": [],
      "timeout": 30
    }
  }
}