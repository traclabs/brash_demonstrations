#!/bin/bash
   
git clone git@github.com:traclabs/cFS.git cFS
pushd cFS
git submodule update --init --recursive
popd 
