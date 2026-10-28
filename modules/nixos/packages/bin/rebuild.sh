set -e

export NIX_CONFIG="access-tokens = github.com=$(gh auth token)"

nh os switch
