{ ... }:

{
    flake.nixosModules.icons = { pkgs, ... }:
    let
        YAMIS = pkgs.stdenv.mkDerivation {
            pname = "yet-another-monochrome-icon-set";
            version = "latest";

            src = pkgs.fetchgit {
                url = "https://bitbucket.org/dirn-typo/yet-another-monochrome-icon-set.git";
                rev = "7f40756b75d3fb22b6a1cf685f472ea855a09956";
                sha256 = "sha256-aKBGmpF5GjhV1Jql4Pd3f+v8GIWm7awqN9OLVv5mtHQ=";
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

        programs.dconf = {
            enable = true;
            profiles.user.databases = [
                {
                    settings."org/gnome/desktop/interface" = {
                        icon-theme = "YAMIS";
                    };
                }
            ];
        };
    };
}
