#!/usr/bin/env bash

echo ""
echo "##### Building pride #####"
echo ""

COMPOSE_FILE="docker-compose-dev.yml"
CODE_DIR="/code"

# Build PRIDE
build_pride_code() {
  docker compose -f ${COMPOSE_FILE} run -w ${CODE_DIR}/pride pride /bin/bash -c "cd view/code && npm install"
  ret=$?
  if [ $ret -ne 0 ]; then
    echo "!! Failed in building PRIDE !!"
    return 1  
  fi
  
  return 0
}

# Build PAX
build_pax() {
  docker compose -f ${COMPOSE_FILE} run -w ${CODE_DIR}/pride pride /bin/bash -c "cd automate/code && ant build"
  ret=$?
  if [ $ret -ne 0 ]; then
    echo "!! Failed in building PAX !!"
    return 1
  fi
  
  return 0
}
 
# Going...
echo "**** Building pride... ****"
build_pride_code
pride_res=$?

if [ $pride_res -eq 1 ]; then
  exit 1
fi

echo "**** Building PAX...****"
build_pax
pax_res=$?

if [ $pax_res -eq 1 ]; then
  exit 1
fi
   
echo ""
echo "##### Done! #####"
exit 0
