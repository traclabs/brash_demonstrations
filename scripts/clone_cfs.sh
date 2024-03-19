#!/bin/bash
   
git clone git@github.com:traclabs/cFS.git cFS
pushd cFS
git submodule init
git submodule update
popd 
