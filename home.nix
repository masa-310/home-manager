{ config, pkgs, ... }:

let
  homedir = builtins.getEnv "HOME";
in
{
  # Let Home Manager install and manage itself.
  fonts.fontconfig.enable = true;
  home = {
    keyboard.layout = "us";
    #keyboard.language = "en";
    packages = with pkgs; [
      google-chrome
      thunderbird
      slack
      nodejs
      yarn
      zsh
    ];
  };

  programs = {
    home-manager.enable = true;
    command-not-found = {
      enable = true;
    };
    feh = {
      enable = true;
    };
    firefox = {
      enable = true;
      enableAdobeFlash = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    git = {
      enable = true;
      userName = "Masashi SATO";
      userEmail = "gmasa.310@gmail.com";
      package = pkgs.git;
      aliases = {
        ch = "checkout";
        cm = "commit";
        ad = "add";
        df = "diff";
        lg = "log";
        pl = "pull";
        ps = "push";
      };
      ignores = [
        "*.swp"
      ];
    };
    htop = {
      enable = true;
    };
    jq = {
      enable = true;
    };
    #lsd = {
    #  enable = true;
    #};
    neovim = {
      enable = true;
      vimAlias = true;
      withPython3 = true;
      configure = {
      	customRC = builtins.readFile("${homedir}/home-manager/.dotfiles/nvim/init.vim");
      };
    };
    ssh = {
      enable = true;
      controlMaster = "auto";
      controlPersist = "60m";
    };
    taskwarrior = {
      enable = true;
    };
    tmux = {
      enable = true;
    };
    urxvt = {
      enable = true;
      package = pkgs.rxvt_unicode;
      fonts = ["xft: DejaVu\ Sans\ Mono\ for\ Powerline:antialias=true:size=11:hinting=true"];
      scroll.bar = {
        enable = true;
      };
    };
    zsh = {
      initExtra = builtins.readFile("${homedir}/home-manager/.dotfiles/.zshrc");
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      autocd = true;
      defaultKeymap = "emacs";
      #dotDir = "./home_manager";
      history = {
        ignoreDups = true;
      };
    };
  };
  
  xresources = {
    extraConfig = builtins.readFile("${homedir}/home-manager/.dotfiles/.Xresources");
  };

  xsession = {
    enable = true;
    pointerCursor = {
      #package = pkgs.redglass;
      #name = "redglass";
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 16;
    };
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = p: [
          p.xmonad-contrib
          p.xmonad-extras
        ];
        config = "${homedir}/home-manager/.dotfiles/xmonad.hs";
      };
    };
  };
}