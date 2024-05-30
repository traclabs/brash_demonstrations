#!/bin/bash

PRIDE_BRANCH='demos/brash' # develop, maars-devel
SPACEROS_PROCEDURE_SVN='https://svn.traclabs.com/svn/pride/trunk/procedures/BRASH'
PRIDE_SYSREP_SVN='https://svn.traclabs.com/svn/ontology/trunk/docs/yaml_sysreps'
   
git clone git@bitbucket.org:traclabs/pride.git -b $PRIDE_BRANCH

echo "** Check out the spaceros procedures repository **"
pushd pride/view/code
svn co $SPACEROS_PROCEDURE_SVN prl
popd

echo "** Cloning PAX SysREPS **"
pushd pride/automate/code/resources
svn co $PRIDE_SYSREP_SVN
popd

echo "**** Done ****"

