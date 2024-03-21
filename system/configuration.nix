{ config, pkgs, inputs, ... }:

{
  # import all our modules!
  imports = [
    ./hardware-configuration.nix
    ./modules/core.nix
    ./modules/gaming.nix
    ./modules/development.nix
    ./modules/hyprland.nix
    ./modules/sound.nix
    ./modules/fonts.nix
  ];
    
  # bootloader, using grub as i have uefi, not bios
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # networking
  networking.networkmanager.enable = true;

  # time zone.
  time.timeZone = "Europe/London";

  # internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # keyboard
  services.xserver.xkb.layout = "gb";
  services.xserver.xkb.variant = "";

  # console keymap
  console.keyMap = "uk";

  # printing
  services.printing.enable = true;

  # bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # controllers
  hardware.xpadneo.enable = true;

  # users
  users.users.stormytuna = {
    isNormalUser = true;
    description = "stormytuna";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # auto-login
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "stormytuna";

  # allow unfree + insecure (whatever that means) packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
