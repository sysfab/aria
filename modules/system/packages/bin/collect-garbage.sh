set -e

nh clean all

read -r -p "Do you want to optimize store? [Y/n]: " answer
if [[ ! "$answer" =~ ^[Nn]$ ]]; then
    nix store optimise
fi
