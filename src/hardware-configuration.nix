{ 
  imports = [ 
    ./hardware-configuration.nix 
  ];

  # Enable Nvidia drivers
  hardware.nvidia = {
    modesetting.enable = true;
    prime = {
      offload.enable = true; # For hybrid GPU setups
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}