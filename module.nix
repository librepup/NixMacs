{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.nixMacs;
  logoImage = "${./config/nix_emacs_logo_small.png}";

  exwmDotEl = ./config/exwm.el;
  
  customEorg = pkgs.runCommand "e.org" {} ''
    substitute ${./config/e.org} $out \
      --replace "~/Pictures/nix_emacs_logo_small.png" "${logoImage}"
  '';

  hoon-mode = pkgs.stdenv.mkDerivation {
    pname = "hoon-mode";
    version = "latest";

    src = pkgs.fetchFromGitHub {
      owner = "urbit";
      repo  = "hoon-mode.el";
      #rev   = "main";
      rev = "master";
      sha256 = "sha256-gOmh3+NxAIUa2VcmFFqavana8r6LT9VmnrJOFLCF/xw=";
    };

    nativeBuildInputs = [ pkgs.emacs ]; # or just pkgs.emacs for byte-compiling

    # If there is no build system, skip straight to install.
    buildPhase = "true";

    installPhase = ''
      install -d $out/share/emacs/site-lisp
      install -m644 hoon-mode.el hoon-dictionary.json $out/share/emacs/site-lisp/
    '';
  };
  
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
    hoon-mode
    (melpaPackages.exwm.overrideAttrs (old: {
      version = "0.34";
      src = pkgs.fetchFromGitHub {
        owner = "emacs-exwm";
        repo = "exwm";
        rev = "254fa6c43f2e2c29f87dcac404a054a393a6a0ea";
        sha256 = "sha256-7Z8vkmkMFsZnBfiadoKNiaJd1+RvCr2OxW1EiY9xY4s=";
      };
    }))
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

    # EXWM Config File
    home.file.".exwm.el" = {
      source = exwmDotEl;
    };

    # EXWM Desktop Entry
    home.file.".local/share/xsessions/nixmacs-exwm.desktop".text = ''
      [Desktop Entry]
      Name=EXWM (nixmacs)
      Comment=Emacs EXWM Window Manager
      Exec=${nixmacs}/bin/${cfg.binaryName}
      Type=Application
      DesktopNames=EXWM
    '';
  };
}