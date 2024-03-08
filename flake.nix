{
    description = "Test flake!";

    inputs = { 
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
        home-manager.url = "github:nix-community/home-manager/release-23.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };
    
    outputs = { self, nixpkgs, home-manager, ... }:
    let
        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in {
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                system = "x86_64-linux";
                modules = [ ./configuration.nix ];
            };
        };
        homeConfigurations = {
            stormytuna = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./home.nix ];
            };
        };
    };
}