#!/bin/bash
   

echo "** Check out OpenMCT traclabs repository **"
git clone git@bitbucket.org:traclabs/openmct-ros openmct_ros
cd openmct_ros
echo  "Set the location where the bridge is running (rosgsw machine, port 9080, check your launch file to confirm"
sed -i 's/ws:\/\/rosmachine:9090/ws:\/\/10.5.0.2:9080/g' example/index.js
echo "**** Done ****"

