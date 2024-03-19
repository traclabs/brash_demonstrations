#!/bin/bash
   
git clone git@github.com:traclabs/brash.git brash
pushd brash
mkdir src
git checkout main
vcs import src < https.repos
popd 
