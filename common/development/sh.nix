{ pkgs, ... }:
{
  users.users.mou.packages = with pkgs; [
    shellcheck
  ];
}
