{
  description = "Reusable NixEmacs Configuration Module";

  outputs = { self, nixpkgs, home-manager, ... }: {
    # Export the module for home-manager
    homeManagerModules.default = import ./module.nix;
    
    # Convenience alias
    homeManagerModules.nixMacs = self.homeManagerModules.default;
  };
}