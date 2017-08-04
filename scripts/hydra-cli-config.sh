#!/bin/ash

# Configure hydra defaults using the cli.
# We are linking to another container running a redis as a service called... 'redis' (!!)
source ~/.profile
hydra-cli config hpp << ANSWERS
redis
6379
10
ANSWERS
echo "services config:"
hydra-cli config list
echo "services routes:"
hydra-cli routes