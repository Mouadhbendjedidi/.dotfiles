{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mouadh";
  home.homeDirectory = "/home/mouadh";
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = [
    pkgs.curl
    pkgs.wget
    pkgs.unzip
    pkgs.sl
    pkgs.cmatrix
    pkgs.neovim
    pkgs.htop
    pkgs.bat
    pkgs.eza
    pkgs.zoxide
    pkgs.ripgrep
    pkgs.starship
    pkgs.fzf
    pkgs.bottom
    pkgs.tree
    pkgs.yazi
    pkgs.tmux
    pkgs.lsd
    pkgs.neofetch
    pkgs.gcc
    pkgs.glow
    pkgs.pandoc
    pkgs.lazygit
    pkgs.rustup
    pkgs.rust-analyser
    pkgs.cargo-watch
  ];

  home.file = {
 
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  
  # my zsh config
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    prezto.tmux.autoStartLocal = true;
    prezto.tmux.autoStartRemote = true;

    history = {
      size = 5000;
      save = 5000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignoreDups = true;
      share = true;
      expireDuplicatesFirst = true;
    };

    shellAliases = {
      ls = "lsd -a";
      ll = "lsd -a -l";
      vim = "nvim";
      c = "clear";
    };

    initContent = ''
      bindkey -e
      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward
      bindkey '^[w' kill-region

      eval "$(fzf --zsh)"
      eval "$(zoxide init --cmd cd zsh)"
    '';
    plugins = [
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "master"; # or specific commit
	  sha256 = "sha256-wJHa/j8yxGvzP8XxJ3wizGe9gfyzsVlkCHKXCcAvUs4=";
        };
      }
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "master";
	  sha256 = "sha256-zc9Sc1WQIbJ132hw73oiS1ExvxCRHagi6vMkCLd4ZhI=";
        };
      }
    ];
  };

  # My Git Setup
  programs.git = {
    enable = true;
    userName = "Mouadhbendjedidi"; # <- YOUR NAME
    userEmail = "alfadjr2007@gmail.com"; # <- YOUR EMAIL
    extraConfig = {
      core = {
        editor = "nvim"; # or "vim" or anything you want
      };
      init.defaultBranch = "main"; # optional
    };
  };

  # starship setup!
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$directory$git_branch$character";
      character = {
        success_symbol = "[](blue)";
	error_symbol = "[](red)";
	vicmd_symbol = "[](green)";
      };
      directory = {
        format = "[]($style)[  $path](bg:#b4befe fg:#1e1e2e)[ ]($style)";
	style = "bg:#1e1e2e fg:#b4befe";
      };
      git_branch = {
        format = "[]($style)[  $branch](bg:#f38ba8 fg:#1e1e2e)[ ]($style)";
	style = "bg:#1e1e2e fg:#f38ba8";
      };
    };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };
}
