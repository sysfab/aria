{ ... }:

{
    flake.nixosModules.icons = { pkgs, ... }:
    let
        YAMIS = pkgs.stdenv.mkDerivation {
            pname = "yet-another-monochrome-icon-set";
            version = "latest";

            src = pkgs.fetchgit {
                url = "https://bitbucket.org/dirn-typo/yet-another-monochrome-icon-set.git";
                rev = "40baf4612a8a73ed0f5a75cdf073db476aa3ca99";
                sha256 = "sha256-bBCwWzPf7k7a3RwP4L90xeTwk+YkKrS9sxRb9KLnBL4=";
            };

            installPhase = ''
                mkdir -p $out/share/icons/YAMIS
                cp -r * $out/share/icons/YAMIS/
            '';
        };
    in
    {
        environment.systemPackages = [
            YAMIS
        ];
    };
}
