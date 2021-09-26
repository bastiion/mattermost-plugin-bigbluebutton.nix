{
  description = "A simple Go flake";

  nixConfig.bash-prompt = "\\033[0;33m\\033[1m\[dev-golden-go\] \\w\\033[0m\\033[0m$ ";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:

    let
      forCustomSystems = custom: f: nixpkgs.lib.genAttrs custom (system: f system);
      allSystems = [ "x86_64-linux" "i686-linux" "aarch64-linux" "x86_64-darwin" ];
      devSystems = [ "x86_64-linux" "x86_64-darwin" ];
      forAllSystems = forCustomSystems allSystems;
      forDevSystems = forCustomSystems devSystems;

      nixpkgsFor = forAllSystems (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ self.overlay ];
        }
      );

      repoName = "golden-go";
      repoVersion = nixpkgsFor.x86_64-linux.golden-go.version;
      repoDescription = "golden-go - A simple Go flake";
    in
    {
      overlay = final: prev: {
        golden-go = with final; callPackage ./derivation.nix { src = self; };
      };

      devShell = forDevSystems (system:
        let pkgs = nixpkgsFor.${system}; in pkgs.callPackage ./shell.nix { }
      );
      hydraJobs = {
        build = forDevSystems (system: nixpkgsFor.${system}.golden-go);

        release = forDevSystems (system:
          with nixpkgsFor.${system}; releaseTools.aggregate
            {
              name = "${repoName}-release-${repoVersion}";
              constituents =
                [
                  self.hydraJobs.build.${system}
                ] ++ lib.optionals (hostPlatform.isLinux) [
                  #self.hydraJobs.deb.x86_64-linux
                  #self.hydraJobs.rpm.x86_64-linux
                  #self.hydraJobs.coverage.x86_64-linux
                ];
              meta.description = "hydraJobs: ${repoDescription}";
            });
      };

      packages = forAllSystems (system:
        with nixpkgsFor.${system}; {
          inherit golden-go;
        });

      defaultPackage = forAllSystems (system:
        self.packages.${system}.golden-go);

      apps = forAllSystems (system: {
        golden-go = {
          type = "app";
          program = "${self.packages.${system}.golden-go}/bin/cli_golden";
        };
      }
      );

      defaultApp = forAllSystems (system: self.apps.${system}.golden-go);

      templates = {
        golden-go = {
          description = "template - ${repoDescription}";
          path = ./.;
        };
      };

      defaultTemplate = self.templates.golden-go;
    };
}
