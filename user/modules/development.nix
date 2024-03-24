{ pkgs, lib, ... }:

{
  # vscode
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      bmalehorn.vscode-fish
      ms-dotnettools.csharp
    ];
    userSettings = {
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;
      "window.titleBarStyle" = "custom"; # Fix crashing with hyprland
    };
  };

  home.packages = with pkgs; [ 
    sublime # TODO: Investigate alternatives, CLION is jetbrains vsc alternative i think?
    jetbrains.rider
    msbuild
    avalonia-ilspy
    github-desktop
    godot_4
    alejandra
  ];
}
