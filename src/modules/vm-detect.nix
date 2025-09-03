{ config, lib, pkgs, ... }:

with lib;

let
  isVM = config.virtualisation.vmVariant || builtins.pathExists "/sys/class/dmi/id/product_name";
in {
  options = {
    system.isVM = mkOption {
      type = types.bool;
      default = isVM;
      description = "Whether the system is running in a virtual machine";
      readOnly = true;
    };
  };

  config = mkIf isVM {
    # VM-specific system configurations
    environment.variables = {
      "LIBGL_ALWAYS_SOFTWARE" = "1";
      "WLR_RENDERER" = "pixman";
      "WLR_NO_HARDWARE_CURSORS" = "1";
    };
    
    # Additional VM packages
    environment.systemPackages = with pkgs; [
      spice-vdagent
      xorg.xrandr
      mesa
    ];
  };
}