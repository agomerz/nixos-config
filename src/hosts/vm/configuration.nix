{ config, pkgs, ... }:
{ 
  imports = [ 
      ./hardware-configuration.nix
  ]; 

  virtualisation.qemu.guest.enable = true;
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;
  services.xserver.videoDrivers = [ "qxl" "virtio" ];
  boot.initrd.availableKernelModules = [ "virtio_pci" "virtio_scsi" ];
  environment.systemPackages = with nixpkgs.legacyPackages.${system}; [
    spice-vdagent
  ];

}