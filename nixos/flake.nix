{
    description = "nixOS flakes entrypoint";

    nixConfig = {
        substituters = [
            "https://cache.nixos.org"
                "https://nix-community.cachix.org"
        ];
        trusted-public-keys = [
            "nix-community.cachix.org-1:mD9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
    };

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

        home-manager = {
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs: {
        nixosConfigurations = {
            dtl = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./hardware-configuration.nix
                    ./configuration.nix
                    {
                        nix.settings.trusted-users = [ "dtl" ];
                    }
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.dtl = import ./home.nix;
                    }
                ];
            };
        };
    };
}
