{
    description = "stormytuna's Flake";

    inputs = { 
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        stylix.url = "github:danth/stylix";
        nur.url = "github:nix-community/NUR";
    };
    
    outputs = { self, nixpkgs, nixpkgs-stable, home-manager, stylix, nur, ... }:
    let
        system = "x86_64-linux";
        lib = nixpkgs.lib;
        pkgs = (import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            allowUnfreePredicate = (_: true);
            allowInsecure = true;
            permittedInsecurePackages = [
              "electron-25.9.0"
            ];
          };
        });
        pkgs-stable = (import nixpkgs-stable {
          inherit system;
          config = {
            allowUnfree = true;
            allowUnfreePredicate = (_: true);
            allowInsecure = true;
            permittedInsecurePackages = [
              "electron-25.9.0"
            ];
          };
        });
        settings = {
            colourScheme = "dracula";
            wallpaper = "unit-one";
            polarity = "dark";
            # TODO: Add fonts and cursor choice!
        };
    in {
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                system = system;
                modules = [
                  ./system/configuration.nix
                  nur.nixosModules.nur
                ];
                specialArgs = {
                  inherit pkgs-stable;
                };
            };
        };
        homeConfigurations = {
            stormytuna = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ 
                  ./user/home.nix 
                  stylix.homeManagerModules.stylix 
                  nur.nixosModules.nur
                ];
                extraSpecialArgs = { 
                    inherit settings;
                    inherit stylix;
                    inherit pkgs-stable;
                };
            };
        };
    };
}