{
    description = "stormytuna's Flake";

    inputs = { 
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        stylix.url = "github:danth/stylix";
    };
    
    outputs = { self, nixpkgs, home-manager, stylix, ... }:
    let
        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in {
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                system = "x86_64-linux";
                modules = [ ./system/configuration.nix ];
            };
        };
        homeConfigurations = {
            stormytuna = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./user/home.nix stylix.homeManagerModules.stylix ];
                extraSpecialArgs = { inherit stylix; };
            };
        };
    };
}