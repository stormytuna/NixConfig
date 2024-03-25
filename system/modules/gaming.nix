{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam
    lutris
  ];

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