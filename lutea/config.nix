{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./packages.nix
  ];

  sops = {
    defaultSopsFile = ../secrets/lutea.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/mou/.app/config/sops/age/keys.txt";
    secrets = {
      "passwordHashes/root".neededForUsers = true;
      "passwordHashes/mou".neededForUsers = true;
    };
  };

  networking.hostName = "lutea";
  time.timeZone = "America/New_York";

  virtualisation.libvirtd.enable = true;

  # Move to home-manager?
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita";
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      corefonts
      ibm-plex
    ];
    fontconfig.defaultFonts = {
      serif = [ "IBM Plex Serif" ];
      sansSerif = [ "IBM Plex Sans" ];
      monospace = [ "IBM Plex Mono" ];
    };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.swaylock = { }; # Needed for swaylock to work
  };

  services = {
    acpid.enable = true;
    dbus.enable = true;
    flatpak.enable = true;
    fwupd.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          # TODO: When the next release occurs (currently on 0.8.0), the `-x` option will be available
          # NOTE: A future release may check these directories automatically instead of requiring
          # me to set them explicitly
          command = ''
            ${pkgs.greetd.tuigreet}/bin/tuigreet \
              -s /run/current-system/sw/share/wayland-sessions:/run/current-system/sw/share/xsessions \
              -t --time-format '%F %A %R' \
              -r --remember-user-session \
              --power-shutdown 'systemctl poweroff' \
              --power-reboot 'systemctl reboot'
          '';
        };
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
    printing.enable = true;
    ratbagd.enable = true;
    smartd.enable = true;
    thermald.enable = true;
    udev.packages = with pkgs; [ game-devices-udev-rules ];
    xserver = {
      desktopManager = {
        # plasma5 = {
        #   enable = true;
        #   # useQtScaling = true; # I'm not sure what this does.
        # };
      };
      wacom.enable = true;
    };
  };


  xdg = {
    mime.enable = true;
    icons.enable = true;
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };
  };

  # These are set in two places at the moment, once here and once with home-manager.
  # If the following issue is dealt with, I could get rid of the home-manager ones.
  environment = {
    loginShellInit = ''
      if [ -e "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh" ]
      then
          . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
      fi
    '';
    pathsToLink = [
      "/share/xsessions"
      "/share/wayland-sessions"
    ];
    # plasma5.excludePackages = with pkgs.plasma5Packages; [
    #   konsole
    #   oxygen
    #   pkgs.aha
    #   plasma-browser-integration
    #   qtvirtualkeyboard
    #   plasma-workspace-wallpapers
    # ];
    sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.app/cache";
      XDG_CONFIG_HOME = "$HOME/.app/config";
      XDG_DATA_HOME = "$HOME/.app/data";
      XDG_STATE_HOME = "$HOME/.app/state";
    };
  };

  users = {
    groups.mou.gid = 1000;
    users = {
      root.hashedPasswordFile = config.sops.secrets."passwordHashes/root".path;
      mou = {
        isNormalUser = true;
        group = "mou";
        extraGroups = [
          "gamemode"
          "libvirtd"
          "users"
          "wheel"
        ];
        shell = pkgs.loksh;
        hashedPasswordFile = config.sops.secrets."passwordHashes/mou".path;
      };
    };
  };

  nix = {
    optimise.automatic = true;
    gc.automatic = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      use-xdg-base-directories = true;
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older
  # NixOS versions. Most users should NEVER change this value after the initial install, for any
  # reason, even if you've upgraded your system to a new NixOS release. This value does NOT affect
  # the Nixpkgs version your packages and OS are pulled from, so changing it will NOT upgrade your
  # system. This value being lower than the current NixOS release does NOT mean your system is out
  # of date, out of support, or vulnerable. Do NOT change this value unless you have manually
  # inspected all the changes it would make to your configuration, and migrated your data
  # accordingly. For more information, see `man configuration.nix` or
  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
