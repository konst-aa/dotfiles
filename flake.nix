{
  description = "Konstantin's flake to pull specific derivations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      packages.x86_64-linux.hypermail = pkgs.callPackage ./nix-stuff/hypermail.nix {  };
      packages.x86_64-linux.default = self.packages.x86_64-linux.hypermail;
    };
}
