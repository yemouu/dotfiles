{ pkgs, yemou-scripts, ... }:
{
  # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ ];
  # nixpkgs.config.permittedInsecurePackages = [ ];

  nixpkgs.overlays = [ yemou-scripts.overlays.default ];

  environment.systemPackages = with pkgs; [
    git
    htop
    man-pages
    man-pages-posix
  ];

  users.users.mou.packages = with pkgs; [
    abduco
    kak-lsp
    magic-wormhole
    nil
    nixpkgs-fmt
    yemou-scripts.packages."x86_64-linux".thm
  ];
}
