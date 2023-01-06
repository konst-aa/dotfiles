{ pkgs ? import <nixpkgs> {} }:
let
  nodeDependencies = (pkgs.callPackage ./default.nix {}).nodeDependencies;
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      dbus
      webkitgtk
      openssl
      zsh
      python3Packages.click
    ];
    nativeBuildInputs = with pkgs; [
      pkg-config
    ];
    dbus = pkgs.dbus;
    shellHook = ''
    '';
  }
