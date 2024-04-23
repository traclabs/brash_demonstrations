#!/usr/bin/env bash

echo ""
echo "##### Building brash #####"
echo ""

COMPOSE_FILE="docker-compose-dev.yml"
CODE_DIR="/code"

build_brash_code() {
  docker compose -f ${COMPOSE_FILE} run -w ${CODE_DIR}/brash rosgsw colcon build --symlink-install
  ret=$?
  if [ $ret -ne 0 ]; then
    echo "!! Failed in colcon build step !!"
    return 1  
  fi
}

# Build juicer
build_juicer_code() {

  docker compose -f ${COMPOSE_FILE} run -w ${CODE_DIR}/juicer rosgsw make
  ret=$?
  if [ $ret -ne 0 ]; then
    echo "!! Failed in make step that builds juicer !!"
    return 1
  fi  
  
}

# Going...
echo "Building brash..."
build_brash_code
echo "Building juicer..."
build_juicer_code

echo ""
echo "##### Done! #####"

