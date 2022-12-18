{pkgs ? import <nixpkgs> {} }: 
let
 stdenv = pkgs.stdenv;
 eggs = import ./profile-eggs.nix { inherit pkgs stdenv; };
in {
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; {
    myNvim = neovim.override {
      configure = {
        customRC = builtins.readFile "/home/konst/.config/nvim/init.vim";
      };
    };
    konst = pkgs.buildEnv {
      name = "konst";
      paths = [
                 # rustup
                 SDL2
                 awscli2
                 black
                 cabal-install
                 cargo
                 chicken
                 clang
                 clang-tools
                 egg2nix
                 elixir
                 fzf
                 ghc
                 haskell-language-server
                 haskellPackages.hindent
                 lsd
                 neofetch
                 neovim
                 node2nix
                 nodePackages.pm2
                 nodejs
                 oh-my-zsh
                 pkg-config
                 python310
                 python310Packages.pip
                 rlwrap
                 rust-analyzer
                 rustc
                 solc
                 tmux
                 tree
                 yarn
      ];
   };
  };
}


