{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam
    lutris
  ];

  # fix steam not loading properly
  hardware.opengl.driSupport32Bit = true;

  programs.gamemode = {
    enable = true;
    settings = {
        custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };
}