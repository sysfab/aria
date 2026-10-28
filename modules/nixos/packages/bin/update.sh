set -e

export NIX_CONFIG="access-tokens = github.com=$(gh auth token)"

pushd "${NH_OS_FLAKE:-$NH_FLAKE}"
nix flake update
popd
