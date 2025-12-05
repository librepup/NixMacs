# NixMacs

A NixOS Flake Module to use my custom configuration of Emacs (NixMacs) easily as a Module inside your Flake.

# Requirements
 - Be at least on **NixOS** Version **25.05** (Warbler)
 - Have **home-manager** Installed

# Installation
## Inside a Flake
**flake.nix**:
```nix
{
  # ... your configuration.
  nixmacs = {
    url = "git+https://codeberg.org/nixpup/NixMacs.git";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };

  outputs = { self, nixpkgs, home-manager, nixmacs, ... }:
  let
    system = "x86_64-linux";
  in
    nixosConfiguration.YOUR_HOSTNAME = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        # ...your modules.
        home-manager.nixosModules.home-manager

        ({ config, pkgs, lib, ... }: 
          imports = [
            home-manager.nixosModules.home-manager
          ];
          home-manager = {
            # ...your home-manager configuration.
            sharedModules = [
              nixmacs.homeManagerModules.default
            ];
          };
        )
      ];
    };
}
```

**home.nix**:
```nix
{ config, pkgs, lib, ... }:
# ...your home configuration.
nixMacs = {
  enable = true;
};
```

# Showcase
![Showcase](https://codeberg.org/nixpup/NixMacs/raw/branch/main/example.png)