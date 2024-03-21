{
    description = "stormytuna's Flake";

    inputs = { 
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        stylix.url = "github:danth/stylix";
        nur.url = "github:nix-community/NUR";
    };
    
    outputs = { self, nixpkgs, home-manager, stylix, nur, ... }:
    let
        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        settings = {
            colourScheme = "espresso";
            wallpaper = "waaaaa";
            polarity = "dark";
            # TODO: Add fonts and cursor choice!
        };
    in {
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                system = "x86_64-linux";
                modules = [ 
                    ./system/configuration.nix
                    nur.nixosModules.nur
                ];
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
                };
            };
        };
    };
}