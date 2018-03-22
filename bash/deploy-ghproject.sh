#!/bin/bash

# Purpose: Deploy an existing github project repo.

VERSION=1.0.0 # github upload version
GH_USERNAME= yourUsername
REPO_NAME= repo-name

rootPath=/home/ubuntu/vmsync
appsPath=$rootPath/fullstack-web/apps
WORKDIR=/path/to/local/repo/${REPO_NAME}

cd $WORKDIR
git add .  
git commit -a -m "project update"
git tag ${VERSION}
git remote add origin https://github.com/${GH_USERNAME}/${REPO_NAME}.git
git push -u origin master

$@ 
