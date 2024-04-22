#!/bin/bash
   
echo "*** Cloning cFS ***"
./scripts/clone_cfs.sh
echo "*** Cloning brash ***"
./scripts/clone_brash.sh
echo "*** Clone juicer ***"
./scripts/clone_juicer.sh
echo "Done!"
