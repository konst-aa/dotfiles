{pkgs ? import <nixpkgs> {} }: 
let
 stdenv = pkgs.stdenv;
 eggs = import ./profile-eggs.nix { inherit pkgs stdenv; };
in {
  allowUnfree = true;
  packageOverrides = pkgs: 
    with pkgs;
    let
      myVim = vim-full.customize {
        vimrcConfig = {
          customRC = builtins.readFile "/home/konst/.config/nvim/init.vim"; # gamer moment
        };
      };
      myNvim = neovim.override {
        configure = {
          customRC = builtins.readFile "/home/konst/.config/nvim/init.vim";
        };
      };
    in {
      konst = pkgs.buildEnv {
        name = "konst";
        paths = [
                   # rustup
                   myVim
                   myNvim
                   #vim-full
        ];
     };
    };
}


