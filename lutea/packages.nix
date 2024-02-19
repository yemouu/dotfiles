{ lib, pkgs, yemou-scripts, ... }:
{
  # nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam" # The steam flatpak doesn't work for my current setup (~/.var as a symlink)
      "steam-original"
      "steam-run"
      "corefonts"
    ];

  # nixpkgs.config.permittedInsecurePackages = [ ];

  imports = [
    ../common/development
    ../common/editor.nix
    ../common/scripts
  ];
  nixpkgs.overlays = [ yemou-scripts.overlays.default ];

  # system.replaceRuntimeDependencies = [
  #   ({
  #     original = pkgs.mesa;
  #     replacement = nixpkgs-staging.legacyPackages.x86_64-linux.mesa;
  #   })
  # ];

  # System Packages
  environment.systemPackages = with pkgs; [
    git
    htop
    man-pages
    man-pages-posix
  ];

  # User Packages
  users.users.mou.packages =
    let
      # Upstream this
      ffmpegthumbnailerFixed = pkgs.ffmpegthumbnailer.overrideAttrs (finalAttrs: previousAttrs: {
        postPatch = previousAttrs.postPatch + ''
          substituteInPlace ./dist/ffmpegthumbnailer.thumbnailer \
            --replace ffmpegthumbnailer $out/bin/ffmpegthumbnailer
        '';
      });
    in
    with pkgs; [
      age
      blender
      chromium
      clang-tools
      dex
      ffmpegthumbnailerFixed
      foot
      gnome.adwaita-icon-theme
      gnome.nautilus
      godot_4
      inkscape
      intel-gpu-tools
      kak-lsp
      kanshi
      libnotify
      lmms
      lsof
      magic-wormhole
      mako
      mpv
      nethogs
      nil
      nixpkgs-fmt
      openssh
      pavucontrol # Are there pipewire specific tools for this?
      piper
      playerctl
      pulseaudio # Are there pipewire specific tools for this?
      rnnoise
      rpcs3
      shellcheck
      sops
      superTuxKart
      swayidle
      swaylock
      syncthing
      wl-clipboard
      wlsunset
      xdg-user-dirs
      yemou-scripts.packages."x86_64-linux".default
    ];

  programs = {
    dconf.enable = true; # Move to home-manager?
    firefox.enable = true; # Move to home-manager?
    gamemode.enable = true;
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam.enable = true;
    sway = {
      enable = true;
      extraPackages = lib.mkForce [ ];
    };
    virt-manager.enable = true;
    wayfire = {
      enable = true;
      package = pkgs.wayfire-with-plugins;
      plugins = with pkgs.wayfirePlugins; [
        wayfire-plugins-extra
        windecor
      ];
    };
    xwayland.enable = true;
  };
}
