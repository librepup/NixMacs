{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.nixMacs;
  logoImage = "${./config/nix_emacs_logo_small.png}";
  
  customEorg = pkgs.runCommand "e.org" {} ''
    substitute ${./config/e.org} $out \
      --replace "~/Pictures/nix_emacs_logo_small.png" "${logoImage}"
  '';
  
  # Create the configured Emacs with packages FIRST
  configuredEmacs = pkgs.emacs.pkgs.withPackages (epkgs: with epkgs; [
    use-package
    color-theme-sanityinc-tomorrow
    company
    emms
    fancy-dabbrev
    lsp-mode
    lsp-ui
    markdown-mode
    multi-term
    multiple-cursors
    nix-buffer
    nix-mode
    rainbow-mode
    rust-mode
    rustic
    wttrin
    hydra
    all-the-icons
    haskell-mode
    arduino-mode
    flycheck
    gruvbox-theme
    bongo
    impatient-mode
    simple-httpd
  ] ++ (cfg.extraPackages epkgs));
  
  # Then create wrapper that references it
  nixmacs = pkgs.writeShellScriptBin cfg.binaryName ''
    exec ${configuredEmacs}/bin/emacs "$@"
  '';
  
in {
  options.nixMacs = {
    enable = mkEnableOption "custom Emacs configuration";
    
    home = mkOption {
      type = types.str;
      default = config.home.homeDirectory or "/home/${config.home.username or "user"}";
      description = "Home directory path";
    };
    
    package = mkOption {
      type = types.package;
      default = pkgs.emacs;
      description = "Emacs package to use";
    };
    
    extraPackages = mkOption {
      type = types.functionTo (types.listOf types.package);
      default = epkgs: with epkgs; [];
      description = "Extra Emacs packages to install";
    };

    binaryName = mkOption {
      type = types.str;
      default = "nixmacs";
      description = "Name of the Emacs binary command";
    };
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      NIXMACS_LOGO_PATH = logoImage;
    };
    
    home.packages = [
      nixmacs  # Only install the wrapper, not both!
      pkgs.rust-analyzer
      pkgs.zathura
      pkgs.mpv
    ];

    home.file.".emacs" = {
      text = ''
        (let ((orgfile "~/.e.org")
              (elfile "~/.e.el"))
          (when (or (not (file-exists-p elfile))
                    (file-newer-than-file-p orgfile elfile))
            (require 'org)
            (org-babel-tangle-file orgfile elfile))
          (load-file elfile))
      '';
    };
    
    # Use the MODIFIED e.org with substituted path
    home.file.".e.org" = {
      source = customEorg;
    };
  };
}