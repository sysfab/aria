{ ... }:

{
    flake.nixosModules.git = { pkgs, ... }: {
        programs.git = {
            enable = true;

            config = {
                credential."https://github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
                credential."https://gist.github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
            };
        };

        environment.systemPackages = [ pkgs.gh ];
    };
}