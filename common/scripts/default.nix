{ pkgs, ... }:
{
  users.users.mou.packages = with pkgs; [
    (callPackage ./bemenu.nix { })
  ];
}
