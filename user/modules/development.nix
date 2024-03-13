{ pkgs, ... }:

{
  # vscode
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      bmalehorn.vscode-fish
    ];
  };

  home.packages = with pkgs; [ 
    sublime # TODO: Investigate alternatives, CLION is jetbrains vsc alternative i think?
    jetbrains.rider
    avalonia-ilspy
    github-desktop
    godot_4
  ];
}
