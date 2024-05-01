#!/bin/bash
   
git clone -b fsw_demos git@github.com:traclabs/cFS.git cFS
pushd cFS
git submodule update --init --recursive
popd 
