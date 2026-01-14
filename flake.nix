{
  description = "ddingg's macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager }:
  let
    # 환경변수에서 읽거나 기본값 사용 (--impure 플래그 필요)
    username = let env = builtins.getEnv "NIX_USER"; in if env != "" then env else "ddingg";
    hostname = let env = builtins.getEnv "NIX_HOSTNAME"; in if env != "" then env else "jomyeong-geun-ui-MacBookPro";
    system = "aarch64-darwin";
  in
  {
    darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
      inherit system;
      
      modules = [
        ./darwin.nix
        
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.${username} = import ./home.nix;
        }
      ];
      
      specialArgs = { inherit inputs username hostname; };
    };
  };
}
