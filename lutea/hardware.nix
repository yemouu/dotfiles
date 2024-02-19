{ lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ ];
    };
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        consoleMode = "auto";
        editor = false;
        enable = true;
      };
      timeout = 0;
    };
    supportedFilesystems = [ "ntfs" ];
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

    # # Impermanence
    # "/" = {
    #   device = "none";
    #   fsType = "tmpfs";
    #   options = [ "mode=755" ];
    # };
    # "/boot" = {
    #   device = "/dev/disk/by-uuid/862D-85DB";
    #   fsType = "vfat";
    #   options = [ "defaults" "fmask=0077" "dmask=0077" ];
    # };
    #"/nix" = {
    #  device = "UUID=e0b979fb-2c29-4e0b-910f-c89e4959c9a0";
    #  fsType = "bcachefs";
    #  options = [ "defaults" "X-mount.subdir=nix-store" ];
    #};
    #"/home-mou" = {
    #  device = "UUID=e0b979fb-2c29-4e0b-910f-c89e4959c9a0";
    #  fsType = "bcachefs";
    #  options = [ "defaults" "X-mount.subdir=home-mou" ];
    #  neededForBoot = true; # This has the decryption key
    #};
    #"/home/mou" = {
    #  device = "none";
    #  fsType = "tmpfs";
    #  options = [ "mode=750" "gid=1000" "uid=1000" ];
    #};
  };

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    cpu.intel.updateMicrocode = true;
    uinput.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [ intel-media-driver ];
    };
  };

  powerManagement.cpuFreqGovernor = "performance";
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
