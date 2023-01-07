{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "konst";
  home.homeDirectory = "/home/konst";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  home.sessionVariables = {
    # VIM_PLUGGED="~/.vim/plugged"; #all it took is inlining the dir for plug
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile "/home/konst/.config/nvim/init.vim"; # gamer moment
    packageConfigurable = pkgs.vim-full;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    oh-my-zsh
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
    # neovim
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
}
