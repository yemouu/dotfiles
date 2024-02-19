{ pkgs, ... }:
{
  users.users.mou.packages = (with pkgs; [
    ruff
  ]) ++
  (with pkgs.python3Packages; [
    ruff-lsp
  ]);
}
