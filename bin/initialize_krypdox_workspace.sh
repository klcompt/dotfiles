#!/bin/bash

repo_names_array=( ca_server common_utils encryptor_api files_api im_ios_sdk im_server ios_secure_assets keystore_api upload_server analytics_api file_processor deadbolt libecies libecies_objc)

if [ "$#" -ne 1 ]; then
    echo "Usage: deploy_source {location_to_clone_repos}"
    exit 1
fi

CLONE_DIR=$1

echo
echo "This script deeply clones the following repos into ${CLONE_DIR}:"
for repo_name in "${repo_names_array[@]}"
do
  echo -e https://gitlab.asynchrony.com/proj-1016/${repo_name}.git " \t\t "
done
echo This may take some time...
read -p "Press [Enter] key to continue"
echo

mkdir ${CLONE_DIR}
cd ${CLONE_DIR}

# and now loop through the repo names:
for repo_name in "${repo_names_array[@]}"
do
  git clone https://gitlab.asynchrony.com/proj-1016/${repo_name}.git
done

echo
echo Sources cloned. DONE!!
echo

