#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "This script shallow clones all repos in your directory,"
    echo "and zips them up for a deployment. It uses a temp directory"
    echo "and will not affect your secure_share_workspace repos."
    echo
    echo "Usage: please run from your secure_share_workspace directory!"
    echo "Usage: deploy_source {git branch to deploy} {output zip file}"
    exit 1
fi
DEPLOY_BRANCH=$1
OUTPUT_FILE=$2
TEMP_DIR=temp_$(date +%F%T)

echo
echo This command will create a zip file of latest shallowly cloned source across all repos.
echo It uses a temp directory for cloning, and will not affect your secure_share_workspace repos.
echo This may take some time...
read -p "Press [Enter] key to continue"
echo

DIRS=`ls -l $MYDIR | egrep '^d' | awk '{print $9}'`
# "ls -l $MYDIR"     = get a directory listing
# "| egrep '^d'"     = pipe to egrep and select only the directories
# "awk '{print $9}'" = pipe the result from egrep to awk and print only the 9th field
# result will be all the repo names

mkdir ${TEMP_DIR}
cd ${TEMP_DIR}

# and now loop through the repo names:
for DIR in $DIRS
do
  git clone https://git.asynchrony.com/proj-1016/${DIR} --depth 1 -b ${DEPLOY_BRANCH}
done

echo
echo Source shallow cloned.  Zipping output...
echo
zip -r ../${OUTPUT_FILE} .
echo
echo Zip file created.  Cleaning up...
cd ..
rm -rf ${TEMP_DIR}
echo Done!
echo



