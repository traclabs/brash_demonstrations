#!/bin/bash

BRASH_BRANCH=fsw_demos   
git clone -b $BRASH_BRANCH git@github.com:traclabs/brash.git brash
pushd brash
mkdir src
vcs import src < https.repos
pushd src
git checkout -b ros2 git@bitbucket.org:traclabs/astrobee_application_tools
popd
popd
