{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yemou-scripts = {
      url = "gitlab:yemou/scripts";
      # url = "path:/home/mou/misc/repos/scripts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    esquid = {
      url = "github:Things-N-Stuff/eSquid";
      # url = "path:/home/mou/misc/repos/eSquid";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops-nix, home-manager, ... }@attrs: {
    nixosConfigurations = {
      # lily = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   specialArgs = attrs;
      #   modules = [
      #     ./lily/config.nix
      #     home-manager.nixosModules.home-manager
      #     {
      #       home-manager.extraSpecialArgs = attrs;
      #       home-manager.useGlobalPkgs = true;
      #       home-manager.useUserPackages = true;
      #       home-manager.users.mou = import ./lily/home.nix;
      #     }
      #   ];
      # };

      lutea = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          ./lutea/config.nix
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = attrs;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mou = import ./lutea/home.nix;
          }
        ];
      };
    };
  };
}
