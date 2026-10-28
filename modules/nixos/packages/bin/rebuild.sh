set -e

if token=$(gh auth token); then
  export NIX_CONFIG="access-tokens = github.com=$token"
fi

nh os switch
