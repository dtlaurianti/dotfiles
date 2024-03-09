{
    description = "nixOS flakes entrypoint";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    };

    outputs = { self, nixpkgs, ... }@inputs: {
        nixosConfigurations.dtl = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./configuration.nix
            ];
        };
    };
}
