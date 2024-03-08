{ config, pkgs, ... }:

{
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

  # fish
		programs.fish = {
		enable = true;
		interactiveShellInit = ''
			set fish_greeting # Disable greeting
		'';
		plugins = [
			{ name = "grc"; src = pkgs.fishPlugins.grc.src; } # grc: colourised command output, package is installed in configuration.nix
		];
  };
}