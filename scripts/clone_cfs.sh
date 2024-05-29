#!/bin/bash
   
CFS_BRANCH=fsw_demos   
git clone -b $CFS_BRANCH git@github.com:traclabs/cFS.git cFS
pushd cFS
git submodule update --init --recursive
popd 
