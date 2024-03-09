{ pkgs, ... }:

{
  # vscode
  programs.vscode = {
    enable = true;
    extensions = [
      pkgs.vscode-extensions.bbenoist.nix
    ];
  };

  # git cli
  programs.git = {
    enable = true;
    userName = "stormytuna";
    userEmail = "stormytuna@outlook.com";
  };
}