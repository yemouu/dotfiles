{ pkgs, ... }:
{
  users.users.mou.packages = with pkgs; [
    typst
    typstfmt
    typst-live
    typst-lsp
  ];
}
