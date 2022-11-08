{
  packageOverrides = pkgs: with pkgs; {
    kasdf = pkgs.buildEnv {
      name = "kasdf";
      paths = [
        fzf
        elixir
        neovim
        oh-my-zsh
        nodejs
      ];
    };
  };
}

