{pkgs ? import <nixpkgs> {} }: 
let
 stdenv = pkgs.stdenv;
 eggs = import ./profile-eggs.nix { inherit pkgs stdenv; };
in {
  allowBroken = true;
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
        chicken
        clang-tools
        egg2nix
        elixir
        fzf
        ghc
        lsd
        neovim
        nodejs
        oh-my-zsh
        python310
        racket
        rlwrap
        tmux
        tree
        vivid
        zsh
      ];
   };
  };
}


