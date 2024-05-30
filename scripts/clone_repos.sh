#!/bin/bash
   
echo "*** Cloning cFS ***"
./scripts/clone_cfs.sh
echo "*** Cloning brash ***"
./scripts/clone_brash.sh
echo "*** Clone juicer ***"
./scripts/clone_juicer.sh
echo "*** Clone PRIDE ***"
./scripts/clone_pride.sh
echo "*** Clone OpenMCT ***"
./scripts/clone_openmct.sh
echo "Done!"
