{ pkgs, pkgs-stable, config, lib, ... }:

{
  home.packages = with pkgs; [
    #alacritty # TODO: wanna test this out after getting themes setup
    #mako # TODO: want to test mako out
    pyprland
    swaynotificationcenter
    libnotify
    swww
    rofi-wayland
    wl-clipboard
    clipse
    wlogout
    grimblast
    pipewire
    wireplumber
    waybar-mpris
  ];

  programs.waybar = {
    enable = true;
    #package = pkgs-stable.waybar;
    #package = (pkgs.waybar.overrideAttrs ( # override lets it work with workspaces properly
    #  oldAttrs: {
    #    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    #  }
    #));
    style = ''
      * {
        /* `otf-font-awesome` is required to be installed for icons */
        font-family: Inconsolata, FontAwesome;
        font-size: 14px;
        font-weight: bold;
      }

      window#waybar {
        background: rgba(0, 0, 0, 0);
        color: #'' + config.lib.stylix.colors.base05 + '';
      }

      window > box {
        opacity: 0.94;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      button {
        border: none;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
        background: inherit;
      }

      #custom-shutdown,
      #tray,
      #custom-notifications,
      #pulseaudio,
      #bluetooth,
      #window,
      #custom-waybar-mpris,
      #mpris,
      #cpu,
      #custom-gpu,
      #memory,
      #network,
      #clock {
        padding: 2px 6px;
        background: #'' + config.lib.stylix.colors.base00 + '';
        color: #'' + config.lib.stylix.colors.base07 + '';
        border-bottom-style: solid;
        border-width: 3px;
        border-color: #'' + config.lib.stylix.colors.base07 + '';
      }

      #workspaces button {
        padding: 0 7px;
        background-color: transparent;
        color: #'' + config.lib.stylix.colors.base07 + '';
        border: none;
        outline: none;
        border-color: rgba(0, 0, 0, 0);
        box-shadow: none;
      }

      @keyframes blink {
        to {
          background-color: #'' + config.lib.stylix.colors.base07 + '';
          color: #'' + config.lib.stylix.colors.base00 + '';
        }
      }

      label:focus {
        background-color: #'' + config.lib.stylix.colors.base00 + '';
      }

      #custom-shutdown {
        color: #'' + config.lib.stylix.colors.base08 + '';
        border-color: #'' + config.lib.stylix.colors.base08 + '';
        border-radius: 8px 0px 0px 8px;
      }
      
      #tray {
        color: #'' + config.lib.stylix.colors.base09 +'';
        border-color: #'' + config.lib.stylix.colors.base09 +'';
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }

      #custom-notifications {
        color: #'' + config.lib.stylix.colors.base0A + '';
        border-color: #'' + config.lib.stylix.colors.base0A + '';
      }

      #pulseaudio {
        color: #'' + config.lib.stylix.colors.base0B + '';
        border-color: #'' + config.lib.stylix.colors.base0B + '';
      }

      #bluetooth {
        color: #'' + config.lib.stylix.colors.base0C + '';
        border-color: #'' + config.lib.stylix.colors.base0C + '';
      }

      #window {
        border-radius: 0px 8px 8px 0px;
        color: #'' + config.lib.stylix.colors.base0D + '';
        border-color: #'' + config.lib.stylix.colors.base0D + '';
      }

      #custom-waybar-mpris {
        border-radius: 8px;
        color: #'' + config.lib.stylix.colors.base0F + '';
        border-color: #'' + config.lib.stylix.colors.base0F + '';
      }

      #mpris {
        border-radius: 8px;
        color: #'' + config.lib.stylix.colors.base0F + '';
        border-color: #'' + config.lib.stylix.colors.base0F + '';
      }

      #cpu {
        color: #'' + config.lib.stylix.colors.base0C + '';
        border-color: #'' + config.lib.stylix.colors.base0C + '';
        border-radius: 8px 0px 0px 8px;
      }

      #custom-gpu {
        color: #'' + config.lib.stylix.colors.base0B + '';
        border-color: #'' + config.lib.stylix.colors.base0B + '';
      }

      #memory {
        color: #'' + config.lib.stylix.colors.base0A + '';
        border-color: #'' + config.lib.stylix.colors.base0A + '';
      }

      #network {
        color: #'' + config.lib.stylix.colors.base09 +'';
        border-color: #'' + config.lib.stylix.colors.base09 +'';
      }

      #clock {
        color: #'' + config.lib.stylix.colors.base08 + '';
        border-color: #'' + config.lib.stylix.colors.base08 + '';
        border-radius: 0px 8px 8px 0px;
      }
    '';
  };

  #services.dunst = {
  #  enable = true;
  #  settings = {
  #    global = {
  #      monitor = 2;
  #      origin = "top-center";
  #      offset = "0x5";
  #      frame_width = 2;
  #      frame_color = "#${config.lib.stylix.colors.base0A}";
  #      font = lib.mkForce "Inconsolata 10";
  #      format = "<b> > %a</b>\\n\\n<i><b>%s:</b></i>\\n%b";
  #      corner_radius = 8;
  #      icon_position = "left";
  #      max_icon_size = 64;
  #    };
  #    urgency_low = {
  #      background = lib.mkForce "#${config.lib.stylix.colors.base01}";
  #      foreground = lib.mkForce "#${config.lib.stylix.colors.base07}";
  #      frame_color = lib.mkForce "#${config.lib.stylix.colors.base0C}";
  #    };
  #    urgency_normal = {
  #      background = lib.mkForce "#${config.lib.stylix.colors.base01}";
  #      foreground = lib.mkForce "#${config.lib.stylix.colors.base07}";
  #      frame_color = lib.mkForce "#${config.lib.stylix.colors.base0B}";
  #    };
  #    urgency_critical = {
  #      background = lib.mkForce "#${config.lib.stylix.colors.base01}";
  #      foreground = lib.mkForce "#${config.lib.stylix.colors.base07}";
  #      frame_color = lib.mkForce "#${config.lib.stylix.colors.base08}";
  #    };
  #  };
  #};
}