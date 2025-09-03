{ config, lib, pkgs, ... }:

with lib;

let
  # Check for VM indicators without using vmVariant (which is a set, not a boolean)
  # These checks are common ways to detect if we're in a VM
  isVirtual = builtins.pathExists "/sys/class/dmi/id/product_name" &&
              (builtins.match "QEMU|VirtualBox|VMware|UTM" 
               (builtins.readFile "/sys/class/dmi/id/product_name") != null);
in {
  options = {
    system.isVM = mkOption {
      type = types.bool;
      default = isVirtual;
      description = "Whether the system is running in a virtual machine";
      readOnly = true;
    };
  };

  config = mkIf config.system.isVM {
    # VM-specific system configurations
    environment.variables = {
      "LIBGL_ALWAYS_SOFTWARE" = "1";
      "WLR_RENDERER" = "pixman";
      "WLR_NO_HARDWARE_CURSORS" = "1";
    };
    
    # Additional VM packages
    environment.systemPackages = with pkgs; [
      spice-vdagent
    ];
  };
}