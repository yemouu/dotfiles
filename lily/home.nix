{ config, ... }:
{
  home.username = "mou";
  home.homeDirectory = "/home/${config.home.username}";

  xdg = {
    enable = true;
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    configFile = {
      "kak" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/misc/repos/setup/data/configs/kak";
        recursive = true;
      };
      "kak-lsp" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/misc/repos/setup/data/configs/kak-lsp";
      };
      "loksh" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/misc/repos/setup/data/configs/loksh";
      };
      "thm" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/misc/repos/setup/data/configs/thm";
      };
    };
  };

  # This doesn't prepend the path, it appends it
  # home.sessionPath = [ "${config.home.homeDirectory}/misc/exes" ];
  home.sessionVariables = {
    ENV = "${config.xdg.configHome}/loksh/rc";
    HISTCONTROL = "ignoredups:ignorespace";
    HISTFILE = "${config.xdg.cacheHome}/loksh_history";
    PATH = "${config.home.homeDirectory}/misc/exes:$PATH";
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
