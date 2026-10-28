set -e

if token=$(gh auth token); then
  export NIX_CONFIG="access-tokens = github.com=$token"
fi

pushd "${NH_OS_FLAKE:-$NH_FLAKE}"
nix flake update
popd
