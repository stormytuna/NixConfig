{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam
    lutris
  ];

  # fix steam not loading properly
  hardware.opengl.driSupport32Bit = true;
}