{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
    pname = "yet-another-monochrome-icon-set";
    version = "latest";

    src = pkgs.fetchgit {
        url = "https://bitbucket.org/dirn-typo/yet-another-monochrome-icon-set.git";
        rev = "2b3ad4983f1943e2d6c48951d6b6970ca97b4fa5"; 
        sha256 = "sha256-rt2oMlGQAM5xKzye8JgEeJY5KQ8DCWseaCZux2zCOGQ=";
    };

    installPhase = ''
        mkdir -p $out/share/icons/YAMIS
        cp -r * $out/share/icons/YAMIS/
    '';
}