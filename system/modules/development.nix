{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains.rider
    dotnet-sdk # 6.0.X
    dotnet-sdk_8
    avalonia-ilspy
    github-desktop
    godot_4
  ];
}