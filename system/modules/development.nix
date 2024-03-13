{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dotnet-sdk # 6.0.X
    dotnet-sdk_8
  ];
}