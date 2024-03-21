{ config, pkgs, ... }:

{
  # terminal packages
  home.packages = with pkgs; [
    grc # fish terminal command colouration
    neofetch
    killall
    feh # image viewer
    eza # better ls
    bat # better cat
    diff-so-fancy # better git diff
    tre-command # better tree
    micro # better nano
    ripgrep # search within files
    exiftool # metadata read/writer
    fzf
    speedtest-cli
    ffmpeg
    htop # process viewer
    playerctl # play, pause, skip controls for media
    imagemagick
    screenfetch
    cava
    # stuff for the funnies :3
    cowsay
    cmatrix
    figlet
    lolcat
    asciiquarium
    btop
  ];

  # bash
  programs.bash = {
    enable = true;
    shellAliases = {
      vencord = "sh -c \"$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)\"";
    };
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  # fish, preferred shell
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			set fish_greeting # Disable greeting
      set fish_prompt_pwd_dir_length 100 # Make prompt_pwd super long
      neofetch
		'';
    shellAbbrs = {
      code = "code --no-sandbox"; # without --no-sandbox flag it crashes immediatly after loading fsr
    };
    shellAliases = {
      # easy rebuilds
      nrb-s = "sudo nixos-rebuild switch --flake ~/.dotfiles/#nixos";
      nrb-u = "home-manager switch --flake ~/.dotfiles/#stormytuna; hyprctl reload";
      nrb = "nrb-s; nrb-u";
      cl = "clear; neofetch"; # i like neofetch okay it's not my fault
      zz = "z -";
      ls = "eza";
      ll = "eza --long";
      cat = "bat";
      tree = "tre";
      nano = "micro";
      archfetch = "neofetch --source ~/Documents/AsciiArt/arch-logo";
      refresh-wallpaper = "swww img ~/.config/hypr/wallpaper.png";
    };
    functions = {
      change-theme = {
        description = "Facilitates easy theme switching!";
        argumentNames = [
          "colour_scheme_name" "wallpaper_name"
        ];
        body = ''
          # Prints usage
          argparse h/help v/valid -- $argv
          or return
          if set -ql _flag_help
            echo "change-theme <colour-scheme-name> <wallpaper-name>"
            return 0
          end

          if set -ql _flag_valid
            # Prints valid themes and wallpapers
            echo "Available colour schemes:"
            eza --oneline ~/.dotfiles/user/theming/colour-schemes
            echo
            echo "Available wallpapers:"
            eza --oneline ~/.dotfiles/user/theming/wallpapers
            return 0
          end

          sed -E -i "s/(colourScheme = \").+\";/\1$colour_scheme_name\";/" ~/.dotfiles/flake.nix
          sed -E -i "s/(wallpaper = \").+\";/\1$wallpaper_name\";/" ~/.dotfiles/flake.nix
          nrb-u
          refresh-wallpaper
        '';
      };
    };
		plugins = with pkgs.fishPlugins; [
			{ name = "grc"; src = grc.src; } # grc: colourised command output, package is installed in configuration.nix
      { name = "bass"; src = bass.src; } # bass: utility for running bash scripts
		];
  };

  # kitty, you can haz fish integration (wahh)
  programs.kitty = {
    enable = true;
    theme = "Cherry";
    settings = {
      confirm_os_window_close = 0;
    };
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
    };
    shellIntegration.enableFishIntegration = true;
  };

  # never thought id be configuring "thefuck" when i switched to linux but here we are...
  programs.thefuck = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
