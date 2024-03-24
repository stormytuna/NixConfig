{ config, pkgs, pkgs-stable, ... }:

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
    #ffmpeg
    htop # process viewer
    playerctl # play, pause, skip controls for media
    imagemagick
    screenfetch
    cava
    btop
    # stuff for the funnies :3
    cowsay
    cmatrix
    figlet
    lolcat
    asciiquarium
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

      system-rebuild = {
        description = "Streamlines rebuilding the system config";
        body = ''
          z ~/.dotfiles

          # early return if no changes were detected
          git diff --quiet "flake.nix" "system/*"
          if test $status -eq 0
            echo "No changes found, exiting..."
            z -
            return 0
          end

          # autoformat nix files
          alejandra "flake.nix" "system/*" &> /dev/null
          if test $status -ne 0
            echo "Failed to format .nix files!"
            return 1
          end

          # print changes
          git diff -U0 "flake.nix" "system/*"

          echo "Rebuilding system..."

          # rebuild, print logs if it failed
          sudo nixos-rebuild switch --flake .#nixos &> system-rebuild.log
          if test $status -ne 0
            cat system-rebuild.log | grep --color error
            return 1
          end

          # get current generation metadata
          set current_gen = (nixos-rebuild list-generations --flake ~/.dotfiles | grep current)

          # commit changes with current generation metadata
          git add "flake.nix" "system/*"
          git commit -m "$current_gen"

          # go back to where we were
          z -

          # notification for all okay
          notify-send -e "System rebuild OK!"
        '';
      };

      user-rebuild = {
        description = "Streamlines rebuilding the user config";
        body = ''
          z ~/.dotfiles

          # early return if no changes were detected
          git diff --quiet "flake.nix" "user/*"
          if test $status -eq 0
            echo "No changes found, exiting..."
            z -
            return 0
          end

          # autoformat nix files
          alejandra "flake.nix" "user/*" &> /dev/null
          if test $status -ne 0
            echo "Failed to format .nix files!"
            return 1
          end

          # print changes
          git diff -U0 "flake.nix" "user/*"

          echo "Rebuilding user..."

          # rebuild, print logs if it failed
          home-manager switch --flake .#stormytuna &> user-rebuild.log
          if test $status -ne 0
            cat user-rebuild.log | grep --color error
            return 1
          end

          # get current generation metadata
          set current_gen = (home-manager generations | head --lines 1)

          # commit changes with current generation metadata
          git add "flake.nix" "user/*"
          git commit -m "$current_gen"

          # go back to where we were
          z -

          # notification for all okay
          notify-send -e "User rebuild OK!"
        '';
      };

      # TODO: Finish this :3
      #git-squash = {
      #  description = "Squashes the past n commits into one commit with a given message";
      #  body = ''
      #    
      #  '';
      #}
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
    package = pkgs-stable.thefuck;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
