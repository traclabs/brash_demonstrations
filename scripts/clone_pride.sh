#!/bin/bash
   
git clone git@bitbucket.org:traclabs/pride.git -b develop

echo "Check out the demo repository"
pushd pride/view/code
svn co https://svn.traclabs.com/svn/pride/trunk/procedures/ros_demo prl
popd

echo "Cloning PAX SysREPS..."
pushd pride/automate/code/resources
svn co https://svn.traclabs.com/svn/ontology/trunk/docs/yaml_sysreps
popd



