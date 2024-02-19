{ config, lib, ... }:
{
  home.username = "mou";
  home.homeDirectory = "/home/${config.home.username}";

  xdg = {
    enable = true;
    cacheHome = "${config.home.homeDirectory}/.app/cache";
    configHome = "${config.home.homeDirectory}/.app/config";
    dataHome = "${config.home.homeDirectory}/.app/data";
    stateHome = "${config.home.homeDirectory}/.app/state";
    userDirs = {
      enable = true;
      desktop = "${config.home.homeDirectory}/misc/.desktop";
      documents = "${config.home.homeDirectory}/docs";
      download = "${config.home.homeDirectory}/dls";
      music = "${config.home.homeDirectory}/aud";
      pictures = "${config.home.homeDirectory}/pics";
      publicShare = "${config.home.homeDirectory}/misc/.public";
      templates = "${config.home.homeDirectory}/misc/.templates";
      videos = "${config.home.homeDirectory}/vids";
    };
    configFile = {
      "autostart" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/misc/repos/setup/data/configs/autostart";
      };
      "foot" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/misc/repos/setup/data/configs/foot";
      };
      "gtk-3.0" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/misc/repos/setup/data/configs/gtk-3.0";
      };
      "kak" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/misc/repos/setup/data/configs/kak";
        recursive = true;
      };
      "kak-lsp" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/misc/repos/setup/data/configs/kak-lsp";
      };
      "kanshi" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/misc/repos/setup/data/configs/kanshi";
      };
      "loksh" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/misc/repos/setup/data/configs/loksh";
      };
      "mpv" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/misc/repos/setup/data/configs/mpv";
      };
      "sway" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/misc/repos/setup/data/configs/sway";
      };
      "scr" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/misc/repos/setup/data/configs/scr";
      };
      "thm" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/misc/repos/setup/data/configs/thm";
      };
      "waybar" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/misc/repos/setup/data/configs/waybar";
      };
      "wayfire.ini" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/misc/repos/setup/data/configs/wayfire.ini";
      };
    };
  };

  fonts.fontconfig.enable = true;
  # gtk = {
  #   enable = true;
  # };

  # home.pointerCursor = {
  #   package = pkgs.vanilla-dmz;
  #   name = "Vanilla-DMZ";
  #   gtk.enable = true;
  # };

  # Fix shell scripts to use full paths and then replace this
  # Bring it back once we get a sessionPrependPath or something similar
  # home.sessionPath = [ "${config.home.homeDirectory}/misc/exes" ];
  home.sessionVariables = {
    ENV = "${config.xdg.configHome}/loksh/rc";
    HISTCONTROL = "ignoredups:ignorespace";
    HISTFILE = "${config.xdg.cacheHome}/loksh_history";
    PATH = "${config.home.homeDirectory}/misc/exes:$PATH";
    SLURP_ARGS = "-b 00000040 -w 0";
    XDG_DATA_DIRS = "${config.home.homeDirectory}/.app/data/flatpak/exports/share:$XDG_DATA_DIRS";
  };

  programs = {
    git = {
      enable = true;
      userEmail = "yemou@butwho.xyz";
      userName = "yemou";
    };
  };

  home.stateVersion = "24.05";
}
