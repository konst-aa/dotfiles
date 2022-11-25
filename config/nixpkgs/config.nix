{pkgs ? import <nixpkgs> {} }: 
let
 stdenv = pkgs.stdenv;
 eggs = import ./profile-eggs.nix { inherit pkgs stdenv; };
in {
  packageOverrides = pkgs: with pkgs; {
    konst = pkgs.buildEnv {
      name = "konst";
      paths = [
        black
        chicken
        egg2nix
        elixir
        fzf
        ghc
        neovim
        nodejs
        oh-my-zsh
        python310
        rlwrap
        tmux
        tree
      ];
   };
  };
}


