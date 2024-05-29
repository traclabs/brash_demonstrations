#!/bin/bash

BRASH_BRANCH=fsw_demos   
git clone -b $BRASH_BRANCH git@github.com:traclabs/brash.git brash
pushd brash
mkdir src
vcs import src < https.repos
popd 
