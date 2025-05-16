{ inputs, config, lib, pkgs, ... }:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];
  
  wsl.enable = true;
  wsl.defaultUser = "mouadh";
 
  time.timeZone = "Africa/Algiers";
  
  networking.hostName = "bendjedidi";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
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
  ];


  # Installs zsh
  programs.zsh.enable = true;
  
  # setting up nix-ld and vscode server
  programs.nix-ld = {
    enable = true;
  };

  # Install NixOS Experimental Features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Sets up the username
  users.users.mouadh = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
  
  system.stateVersion = "24.11"; 
}
