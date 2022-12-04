{pkgs ? import <nixpkgs> {} }: 
let
 stdenv = pkgs.stdenv;
 eggs = import ./profile-eggs.nix { inherit pkgs stdenv; };
in {
  allowBroken = true;
  allowUnfree = true;
  permittedInsecurePackages = [
    "adobe-reader-9.5.5"
  ];
  allowUnsupportedSystem = true;
  packageOverrides = pkgs: with pkgs; {
    myNvim = neovim.override {
      configure = {
        customRC = builtins.readFile "/home/konst/.config/nvim/init.vim";
      };
    };
    konst = pkgs.buildEnv {
      name = "konst";
      paths = [
        black
        cabal-install
        chicken
        clang-tools
        egg2nix
        elixir
        fzf
        ghc
        haskell-language-server
        lsd
        neofetch
        neovim
        nodejs
        oh-my-zsh
        python310
        rlwrap
        tmux
        tree
        zsh
      ];
   };
  };
}


