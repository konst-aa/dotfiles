{
  packageOverrides = pkgs: with pkgs; {
    konst = pkgs.buildEnv {
      name = "konst";
      paths = [
        cyclone-scheme
        elixir
        fzf
        neovim
        nodejs
        python310
      ];
    };
  };
}


