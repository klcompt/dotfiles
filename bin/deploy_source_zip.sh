#!/bin/bash

repo_names_array=( ca_server common_utils encryptor_api files_api im_ios_sdk im_server ios_secure_assets keystore_api upload_server analytics_api file_processor)

if [ "$#" -ne 2 ]; then
    echo "Usage: deploy_source {git branch, tag, or SHA to deploy} {output zip file}"
    exit 1
fi
DEPLOY_BRANCH=$1
OUTPUT_FILE=$2
TEMP_DIR=temp_$(date +%F%T)

echo
echo "This script shallow clones the following repos:"
for repo_name in "${repo_names_array[@]}"
do
  echo -e https://git.asynchrony.com/proj-1016/${repo_name} " \t\t " revision: ${DEPLOY_BRANCH}
done
echo This may take some time...
read -p "Press [Enter] key to continue"
echo

mkdir ${TEMP_DIR}
cd ${TEMP_DIR}

# and now loop through the repo names:
for repo_name in "${repo_names_array[@]}"
do
  git clone https://git.asynchrony.com/proj-1016/${repo_name} --depth 1 -b ${DEPLOY_BRANCH}
  rm -f ${repo_name}/.git/shallow
done
# this repo is in a different location, so cloning separately
git clone https://gitlab.asynchrony.com/proj-1016/deadbolt.git --depth 1 -b ${DEPLOY_BRANCH}
rm -f deadbolt/.git/shallow

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

