{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mouadh";
  home.homeDirectory = "/home/mouadh";
  home.stateVersion = "24.11"; # Please read the comment before changing.

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
    nitch
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
	  sha256 = "sha256-xjGx1kvWioVwSS/n1rcud83ZtGZzZoUp+xx+sfu8hJU=";
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
	style = "bg:#001e1e2e fg:#b4befe";
      };
      git_branch = {
        format = "[]($style)[  $branch](bg:#f38ba8 fg:#1e1e2e)[ ]($style)";
	style = "bg:#001e1e2e fg:#f38ba8";
      };
    };
  };

  # tmux config!
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-online-status'
      set -g @plugin 'tmux-plugins/tmux-battery'
      set -g @plugin 'catppuccin/tmux'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'christoomey/vim-tmux-navigator'

      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # Configure Catppuccin
      set -g @catppuccin_flavor "mocha"
      set -g @catppuccin_status_background "none"
      set -g @catppuccin_window_status_style "none"
      set -g @catppuccin_pane_status_enabled "off"
      set -g @catppuccin_pane_border_status "off"

      # Configure Online
      set -g @online_icon "ok"
      set -g @offline_icon "nok"

      # status left look and feel
      set -g status-left-length 100
      set -g status-left ""
      set -ga status-left "#{?client_prefix,#{#[bg=#{@thm_red},fg=#{@thm_bg},bold]  #S },#{#[bg=#{@thm_bg},fg=#{@thm_green}]  #S }}"
      set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
      set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_maroon}]  #{pane_current_command} "
      set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
      set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_blue}]  #{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}} "
      set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]#{?window_zoomed_flag,│,}"
      set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_yellow}]#{?window_zoomed_flag,  zoom ,}"

      # status right look and feel
      set -g status-right-length 100
      set -g status-right ""
      set -ga status-right "#[bg=#{@thm_bg}]#{?#{==:#{online_status},ok},#[fg=#{@thm_mauve}] 󰖩 on ,#[fg=#{@thm_red},bold]#[reverse] 󰖪 off }"
      set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}, none]│"
      set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_blue}] 󰭦 %Y-%m-%d 󰅐 %H:%M "

      # bootstrap tpm
      if "test ! -d ~/.tmux/plugins/tpm" \
        "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins'"

      # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
      run '~/.tmux/plugins/tpm/tpm'

      # Configure Tmux
      set -g status-position top
      set -g status-style "bg=#{@thm_bg}"
      set -g status-justify "absolute-centre"

      # pane border look and feel
      setw -g pane-border-status top
      setw -g pane-border-format ""
      setw -g pane-active-border-style "bg=#{@thm_bg},fg=#{@thm_overlay_0}"
      setw -g pane-border-style "bg=#{@thm_bg},fg=#{@thm_surface_0}"
      setw -g pane-border-lines single

      # window look and feel
      set -wg automatic-rename on
      set -g automatic-rename-format "Window"

      set -g window-status-format " #I#{?#{!=:#{window_name},Window},: #W,} "
      set -g window-status-style "bg=#{@thm_bg},fg=#{@thm_rosewater}"
      set -g window-status-last-style "bg=#{@thm_bg},fg=#{@thm_peach}"
      set -g window-status-activity-style "bg=#{@thm_red},fg=#{@thm_bg}"
      set -g window-status-bell-style "bg=#{@thm_red},fg=#{@thm_bg},bold"
      set -gF window-status-separator "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}]│"

      set -g window-status-current-format " #I#{?#{!=:#{window_name},Window},: #W,} "
      set -g window-status-current-style "bg=#{@thm_peach},fg=#{@thm_bg},bold"
    '';
  };
  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };
}
