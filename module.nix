{ config, lib, pkgs, ... }:

with lib;

let
  inherit (lib) types mkOption mkEnableOption;
  cfg = config.nixMacs;
  logoImage = "${./config/nix_emacs_logo_small.png}";

  exwmQwerty = ./config/exwm-qwerty.el;
  exwmColemak = ./config/exwm-colemak.el;

  customEorg = pkgs.runCommand "e.org" {} ''
    substitute ${./config/e.org} $out \
      --replace "~/Pictures/nix_emacs_logo_small.png" "${logoImage}"
  '';

  fuwamocoThemeOrg = ''
    * Theme/Colorscheme
    #+BEGIN_SRC emacs-lisp
    (load-theme 'fuwamoco t)
    #+END_SRC
  '';

  marnieThemeOrg = ''
    * Theme/Colorscheme
    #+BEGIN_SRC emacs-lisp
    (load-theme 'marnie t)
    #+END_SRC
  '';

  gruvboxThemeOrg = ''
    * Theme/Colorscheme
    #+BEGIN_SRC emacs-lisp
    (load-theme 'gruvbox-dark-medium t)
    #+END_SRC
  '';

  templeosThemeOrg = ''
    * Theme/Colorscheme
    #+BEGIN_SRC emacs-lisp
    (load-theme 'temple-os t)
    #+END_SRC
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

  exwmFixed = pkgs.emacsPackages.trivialBuild rec {
    pname = "exwm";
    version = "0.34";
    src = pkgs.fetchFromGitHub {
      owner = "emacs-exwm";
      repo = "exwm";
      rev = "0.34";
      sha256 = "sha256-7Z8vkmkMFsZnBfiadoKNiaJd1+RvCr2OxW1EiY9xY4s=";
    };
    packageRequires = [
      pkgs.emacsPackages.compat
      pkgs.emacsPackages.xelb
    ];
  };

  includedPackages = epkgs: with epkgs; [
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
    exwmFixed
    compat
    xelb
    nickel-mode
    iedit
    anzu
    visual-regexp
    try
    sudo-edit
    pdf-tools
    magit
    beacon
    doom-modeline
    vim-tab-bar
  ] ++ (cfg.extraPackages epkgs);

  configuredEmacsX11 = pkgs.emacs.pkgs.withPackages includedPackages;
  configuredEmacsWayland = pkgs.emacs-pgtk.pkgs.withPackages includedPackages;

  # Then create wrapper that references it
  nixmacs = pkgs.writeShellScriptBin cfg.binaryName ''
    exec ${configuredEmacsX11}/bin/emacs "$@"
  '';

  nixmacs-wayland = pkgs.writeShellScriptBin "${cfg.binaryName}-wayland" ''
    exec ${configuredEmacsWayland}/bin/emacs "$@"
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

    waylandPackage = {
      enable = mkOption {
        type = types.bool;
        default = true;
        example = false;
        description = "Whether to build a Wayland Compatible NixMacs Pkg";
      };
    };

    themes = {
      fuwamoco = mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = "Whether to enable or disable the builtin Fuwamoco Theme/Colorscheme";
      };
      marnie = mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = "Whether to enable or disable the builtin Marnie Theme/Colorscheme";
      };
      gruvbox = mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = "Whether to enable or disable the builtin Gruvbox Theme/Colorscheme";
      };
      templeos = mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = "Whether to enable or disable the builtin TempleOS Theme/Colorscheme";
      };
    };
    exwm = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable EXWM Configuration";
      };
      layout = mkOption {
        type = types.enum [ "qwerty" "colemak" ];
        default = "qwerty";
        description = "Keyboard Layout for EXWM";
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = (lib.count (x: x) [
          cfg.themes.fuwamoco
          cfg.themes.marnie
          cfg.themes.gruvbox
          cfg.themes.templeos
        ]) <= 1;
        message = "Error: Only one Theme/Colorscheme can be enabled at a time!";
      }
    ];

    home.sessionVariables = {
      NIXMACS_LOGO_PATH = logoImage;
    } // (optionalAttrs cfg.exwm.enable {
      NIXMACS_EXWM_LAYOUT = cfg.exwm.layout;
    });

    home.packages = [
      nixmacs  # Only install the wrapper, not both!
      pkgs.rust-analyzer
      pkgs.zathura
      pkgs.mpv
    ]
    ++ lib.optional cfg.waylandPackage.enable nixmacs-wayland;

    home.file.".emacs" = {
      text = ''
        (let ((orgfile (expand-file-name "~/.e.org"))
              (elfile  (expand-file-name "~/.e.el")))
          (when (or (not (file-exists-p elfile))
                    (file-newer-than-file-p orgfile elfile))
            (require 'org)
            ;; Force tangling to the specific elfile path
            (org-babel-tangle-file orgfile elfile))

          ;; Safety check: only load if the file actually exists now
          (if (file-exists-p elfile)
              (load-file elfile)
            (message "Warning: %s could not be generated!" elfile)))
      '';
    };

    # Use the MODIFIED e.org with substituted path
    home.file.".e.org" = {
      text = builtins.readFile customEorg
        + optionalString cfg.themes.fuwamoco fuwamocoThemeOrg
        + optionalString cfg.themes.marnie marnieThemeOrg
        + optionalString cfg.themes.gruvbox gruvboxThemeOrg
        + optionalString cfg.themes.templeos templeosThemeOrg;
    };

    # Install Themes
    home.file.".nixmacs/themes/fuwamoco-theme.el" = mkIf cfg.themes.fuwamoco {
      source = ./config/themes/fuwamoco-theme.el;
    };
    home.file.".nixmacs/themes/marnie-theme.el" = mkIf cfg.themes.marnie {
      source = ./config/themes/marnie-theme.el;
    };
    home.file.".nixmacs/themes/temple-os-theme.el" = mkIf cfg.themes.templeos {
      source = ./config/themes/temple-os-theme.el;
    };

    # EXWM Config File
    home.file.".exwm.el" = mkIf cfg.exwm.enable {
      source = if cfg.exwm.layout == "colemak" then exwmColemak else exwmQwerty;
    };
  };
}
