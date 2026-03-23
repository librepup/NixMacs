{
  description = "Reusable NixEmacs Configuration Module";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      hoon-mode = pkgs.stdenvNoCC.mkDerivation {
        pname = "hoon-mode";
        version = "latest";
        src = pkgs.fetchFromGitHub {
          owner = "urbit";
          repo  = "hoon-mode.el";
          #rev   = "main";
          rev = "master";
          sha256 = "sha256-gOmh3+NxAIUa2VcmFFqavana8r6LT9VmnrJOFLCF/xw=";
        };
        dontBuild = true;
        installPhase = ''
          mkdir -p $out/share/emacs/site-lisp
          cp hoon-mode.el hoon-dictionary.json $out/share/emacs/site-lisp/
        '';
      };

      # Standalone nixmacs builder (duplicate logic from module.nix)
      emacsWithPackages = pkgs.emacs.pkgs.withPackages (epkgs: with epkgs; [
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
        compat
        xelb
        nickel-mode
        iedit
        anzu
        visual-regexp
        try
        sudo-edit
        hoon-mode
        pdf-tools
        magit
        beacon
        doom-modeline
        vim-tab-bar
        dired-subtree
      ]);

      nixmacs = pkgs.writeShellScriptBin "nixmacs" ''
        CONF_DIR=$(mktemp -d /tmp/nixmacs-params.XXXXXX)
        ${pkgs.gnused}/bin/sed 's/\r//g; s/\xc2\xa0/ /g' ${./config/e.org} > $CONF_DIR/e.org

        mkdir $CONF_DIR/themes
        cp ${./config/themes/filian-theme.el} $CONF_DIR/themes/filian-theme.el
        sed -i "s|~/.nixmacs/themes/|$CONF_DIR/themes/|g" $CONF_DIR/e.org
        sed -i "s|~/.nixmacs/|$CONF_DIR/|g" $CONF_DIR/e.org
        sed -i "s|~/Music|$CONF_DIR/Music|g" $CONF_DIR/e.org
        mkdir $CONF_DIR/images
        cp ${./config/nix_emacs_logo_small.png} $CONF_DIR/images/nix_emacs_logo_small.png
        sed -i "s|~/Pictures/|$CONF_DIR/images/|g" $CONF_DIR/e.org
        export NIXMACS_LOGO_PATH=$CONF_DIR/images/nix_emacs_logo_small.png
        export HOME=$CONF_DIR

        echo -e "\n* Theme/Colorscheme\n#+BEGIN_SRC\n(load-theme 'filian t)\n#+END_SRC" >> $CONF_DIR/e.org

        ${emacsWithPackages}/bin/emacs \
          --batch \
          --eval "(setq coding-system-for-read 'utf-8-unix)" \
          --eval "(setq coding-system-for-write 'utf-8-unix)" \
          --eval "(require 'org)" \
          --eval "(org-babel-tangle-file \"$CONF_DIR/e.org\" \"$CONF_DIR/e.el\")"

        ${pkgs.gnused}/bin/sed -i 's/\r//g' $CONF_DIR/e.el

        exec ${emacsWithPackages}/bin/emacs \
          --debug-init \
          --name "NixMacs-Demo" \
          --init-directory "$CONF_DIR" \
          --load  "$CONF_DIR/e.el" "$@"
      '';

      nixmacs-client = pkgs.writeShellScriptBin "nixmacs-client" ''
        exec ${emacsWithPackages}/bin/emacsclient "$@"
      '';
    in {
      packages = {
        default = nixmacs;
        nixmacs = nixmacs;
        nixmacs-client = nixmacs-client;
      };
      apps.default = {
        type = "app";
        program = "${nixmacs}/bin/nixmacs";
        meta = {
          description = "NixMacs - custom Emacs build for NixOS";
          mainProgram = "nixmacs";
        };
      };
    }) // {
      homeManagerModules.default = import ./module.nix;
      homeManagerModules.nixMacs = self.homeManagerModules.default;
    };
}
