#!/bin/bash
 
# SpaceROS robots should be sourced already
# source ${HOME_DIR}/spaceros_robots_ws/install/setup.bash

source /src/astrobee/install/setup.bash 
 
if [ -f /code/brash/install/setup.bash ]
then
  source /code/brash/install/setup.bash
fi
  
# Execute the command passed into this entrypoint
exec "$@"
