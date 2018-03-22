#!/bin/bash
# Purpose: backup local folders to aws-s3 bucket
localPath="${HOME}/path/to/local/backup/dir" # local directoy for .tar.gz
bucket="bucket-name" # s3 bucket for .tar.gz
doall(){ 
    dir1
    s3up
}

dir1(){
srcname=dirname;
srcpath="${HOME}/path/to/${srcname}"
tar -cvpzf $localPath/${srcname}.tar.gz --exclude={.ipynb_checkpoints,*.log*,.git,build*,dist,node_modules,.serverless,.webpack} $srcpath
#tar -tf $localPath/${srcname}.tar.gz # to look at contents without untar
#tar xvzf $localPath/${srcname}.tar.gz #  untar in the current directory
}

s3up(){
# NOW upload:
#aws s3 mb s3://$bucket # if the bucket does not exist
aws s3 sync s3://$bucket/latest/ s3://$bucket/archiv/ --delete --only-show-errors
aws s3 sync ${localPath} s3://$bucket/latest/ --delete --only-show-errors
}
$@ 
