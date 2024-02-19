{ lib, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        consoleMode = "auto";
        editor = false;
        enable = true;
      };
      timeout = 0;
    };
    tmp.useTmpfs = true;
  };

  fileSystems = {
    "/" = {
      device = "UUID=e0b979fb-2c29-4e0b-910f-c89e4959c9a0";
      fsType = "bcachefs";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/862D-85DB";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" "defaults" ];
    };
  };

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    cpu.intel.updateMicrocode = true;
    uinput.enable = true;
  };

  swapDevices = [ ];
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
