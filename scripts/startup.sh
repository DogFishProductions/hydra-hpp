#!/bin/ash

# If we run source ~/.profile it will be looking for this file on the host and won't find it!!
# That's why we're using a shell script - it uses the correct scope (i.e. the container).
# We're running this script so that npm can find the directories we need to overcome install permission issues.
source ~/.profile

if [ -d "/home/dogfish/app/service" ]; then
  cd service
  npm install
  echo NODE_ENV=$1
  if [ $2 = "single" ]; then
    echo "we're in single mode"
    npm run susan &
    npm run jane &
    npm run john
  else 
    if [ $2 = "multi" ]; then
      echo "we're in multi mode"
      npm run $3 $4
    fi
  fi
fi