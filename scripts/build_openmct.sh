#!/usr/bin/env bash

echo ""
echo "##### Building openmct #####"
echo ""

COMPOSE_FILE="docker-compose-dev.yml"
CODE_DIR="/code"

build_openmct() {
  docker compose -f ${COMPOSE_FILE} run -w ${CODE_DIR}/openmct_ros rosgsw /bin/bash  -ic "npm install && npm run build:example"
  ret=$?
  if [ $ret -ne 0 ]; then
    echo "!! Failed in building openmct !!"
    return 1  
  fi
  
  return 0
}


# Going...
echo "**** Building openMCT... ****"
build_openmct
openmct_res=$?

if [ $openmct_res -eq 1 ]; then
  exit 1
fi

echo ""
echo "##### Done! #####"
exit 0
