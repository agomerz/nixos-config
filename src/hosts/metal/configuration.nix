{ config, pkgs, ... }:
{ 
  imports = [ 
      ./hardware-configuration.nix
  ]; 

  hardware.nvidia = {
    modesetting.enable = true;
    prime = {
      offload.enable = true;
    };
  };
}