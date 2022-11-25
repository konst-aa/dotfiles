{ nixpkgs ? <nixpkgs> }:
let
  pkgs = import nixpkgs {};
  stdenv = pkgs.stdenv;
  eggs = import ./profile-eggs.nix { inherit pkgs stdenv; };
in
pkgs.eggDerivation {
  src = ./.;

  name = "konst-eggs";
  buildInputs = with eggs; [
    breadline
  ];
}
