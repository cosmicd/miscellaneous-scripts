#!/bin/bash
# Purpose: create a new github project repo.
GH_USERNAME=yourUsername
REPO_NAME=repo-name
REPODESC="a short description."

creat(){
curl -u ${GH_USERNAME} https://api.github.com/user/repos -d "{\"name\": \"${REPO_NAME}\", \"description\": \"${REPODESC}\"}"
}
delete_remote(){ # in case you need to delete the repo
curl -u ${GH_USERNAME} -X DELETE https://api.github.com/repos/${GH_USERNAME}/${REPO_NAME}
}
$@ 