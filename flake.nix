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
      nixmacs = pkgs.writeShellScriptBin "nixmacs" ''
        exec ${pkgs.emacs.pkgs.withPackages (epkgs: with epkgs; [
          use-package color-theme-sanityinc-tomorrow company emms
          fancy-dabbrev lsp-mode lsp-ui markdown-mode multi-term
          multiple-cursors nix-buffer nix-mode rainbow-mode rust-mode
          rustic wttrin hydra all-the-icons haskell-mode arduino-mode
          flycheck gruvbox-theme bongo impatient-mode simple-httpd
          compat xelb nickel-mode iedit anzu visual-regexp try sudo-edit
          hoon-mode pdf-tools magit beacon doom-modeline vim-tab-bar
        ] ++ [
          # Add your custom derivations here if needed
        ])}/bin/emacs "$@"
      '';
    in {
      packages.nixmacs = nixmacs;
      apps.nixmacs = {
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
