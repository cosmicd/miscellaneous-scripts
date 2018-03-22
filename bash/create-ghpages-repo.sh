#!/bin/bash

# Purpose: Delete old and create a new gh-pages repo for static sites

GH_USERNAME=yourUsername
GH_PAGES_NAME=${GH_USERNAME}.github.io
GH_PAGES_REPO_PATH=/path/to/local/$GH_PAGES_NAME # this is the local copy of the build repo

doall(){
 delete_remote 
 delete_local
 create; #  create new repo
}

delete_remote(){
curl -u ${GH_USERNAME} -X DELETE https://api.github.com/repos/${GH_USERNAME}/${GH_PAGES_NAME}
}

delete_local(){ # You may not have want to delete local as it may have demos.
rm -r $GH_PAGES_REPO_PATH
}

create(){
curl -u ${GH_USERNAME} https://api.github.com/user/repos -d "{\"name\": \"${GH_PAGES_NAME}\", \"description\": \"${REPODESC}\"}"
mkdir -p $GH_PAGES_REPO_PATH
cd $GH_PAGES_REPO_PATH
echo '<a href="https://'${GH_PAGES_NAME}'">'${GH_PAGES_NAME}'</a>' >> README.md
git init
git add .
git commit -a -m "first commit"
git remote add origin https://github.com/${GH_USERNAME}/${GH_PAGES_NAME}.git
git push -u origin master
}
$@ 