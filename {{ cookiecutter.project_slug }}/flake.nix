{
  description = "shell with all dependencies";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in
        {
            devShells.default = pkgs.mkShell {
              nativeBuildInputs = [
              pkgs.gccStdenv
              pkgs.stdenv.cc.cc.lib
              pkgs.nodejs
              postgresql_16
              (pkgs.python312.withPackages (p: [
                p.tox
                p.pip-tools
                p.psycopg2
                p.pyzmq
              ]))
              pkgs.ruff
              pkgs.rustywind
              pkgs.tmux
              pkgs.overmind
              ];

              shellHook = ''
              export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
              pkgs.stdenv.cc.cc
              ]}
              '';
              MY_ENVIRONMENT_VARIABLE = "world";
          };
        }
      );
}
