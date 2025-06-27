{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mouadh";
  home.homeDirectory = "/home/mouadh";
  home.stateVersion = "24.11"; # Please read the comment before changing.

<<<<<<< HEAD
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
    pkgs.nitch
    pkgs.gcc
    pkgs.glow
    pkgs.pandoc
    pkgs.lazygit
    pkgs.rustup
    pkgs.cargo-watch
    pkgs.socat
    pkgs.fastfetch
=======
  home.packages = with pkgs; [
    curl
    wget
    unzip
    sl
    cmatrix
    neovim
    htop
    bat
    eza
    zoxide
    ripgrep
    starship
    fzf
    bottom
    tree
    yazi
    tmux
    lsd
    neofetch
    gcc
    glow
    pandoc
    lazygit
    rustup
    cargo-watch
    socat
>>>>>>> 5e87b0a4663b2cbe1982f1e2344e13651ec35afd
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
      c = "clear";
    };

    initContent = ''
      if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
        tmux attach-session -t default || tmux new-session -s default
      fi

      bindkey -e
      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward
      bindkey '^[w' kill-region

      eval "$(fzf --zsh)"
      eval "$(zoxide init --cmd cd zsh)"
      nvim() {
        if ! pidof socat > /dev/null 2>&1; then
          [ -e /tmp/discord-ipc-0 ] && rm -f /tmp/discord-ipc-0
          socat UNIX-LISTEN:/tmp/discord-ipc-0,fork \
              EXEC:"npiperelay.exe //./pipe/discord-ipc-0" 2>/dev/null &
        fi

        if [ $# -eq 0 ]; then
            command nvim
        else
            command nvim "$@"
        fi
        }
    '';
    plugins = [
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "master"; # or specific commit
	  sha256 = "sha256-qCoBWdBZMVmhnd2m5ffXxu0anGigJexeN0KgS+9bmvg=";
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
    userName = "Mouadhbendjedidi"; 
    userEmail = "alfadjr2007@gmail.com"; 
    extraConfig = {
      core = {
        editor = "nvim"; 
      };
      init.defaultBranch = "main"; 
      pull.rebase = false;
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
