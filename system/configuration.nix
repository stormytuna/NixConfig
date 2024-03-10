{ config, pkgs, inputs, ... }:

{
  # import all our modules!
  imports = [
    ./hardware-configuration.nix
    ./modules/core.nix
    ./modules/gaming.nix
    ./modules/development.nix
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

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Inconsolata" ]; })
    powerline
    inconsolata
    inconsolata-nerdfont
    iosevka
    font-awesome
    ubuntu_font_family
    terminus_font
  ];

  # login managers, sddm works better with hyprland
  services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.displayManager.sddm.enable = true;

  # using xfce currently as it works in a VM
  #services.xserver.desktopManager.xfce.enable = true;
  
  # Hyprland, doesn't work in VMs :(
  services.xserver.enable = true; # might need this for xwayland
  services.xserver.layout = "gb";
  services.xserver.xkbVariant = "";
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # tells electron apps to use wayland
  environment.systemPackages = with pkgs; [ 
    (waybar.overrideAttrs ( # override lets it work with workspaces properly
      oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      }
    ))
    dunst # for notifications
    libnotify
    swww
    kitty
    # needed for hyprland but arent installed with it fsr?
    bintools-unwrapped
    pciutils
    rofi-wayland
    #wofi # can use instead of rofi-wayland
  ];
  programs.hyprland = {
    enable = true;
    #xwayland.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

  # console keymap
  console.keyMap = "uk";

  # printing
  services.printing.enable = true;

  # sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # users
  users.users.stormytuna = {
    isNormalUser = true;
    description = "stormytuna";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # auto-login
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "stormytuna";

  # Allow unfree packages
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
