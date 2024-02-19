{ pkgs, ... }:
{
  environment = {
    sessionVariables = {
      EDITOR = "kak";
      VISUAL = "kak";
    };

    systemPackages = with pkgs; [
      kakoune
      file
    ];
  };
}
