{ pkgs, ... }:

{
  # vscode
  programs.vscode = {
    enable = true;
    extensions = [
      pkgs.vscode-extensions.bbenoist.nix
    ];
  };

  # sublime text
  home.packages = with pkgs; [ sublime ];
}
