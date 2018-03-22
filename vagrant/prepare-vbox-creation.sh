#!/bin/bash
# Cleanup script to prepare vm for a box creation. 
# Useage: run after logging into the guest and copying this script to /home/username:
# source it: . filename.sh # do not run using ./filename;

sudo apt-get clean all && sudo apt-get autoclean
sudo apt-get update && sudo apt-get upgrade
sudo apt-get -y autoremove
upath="/home/ubuntu"

sudo rm -rf ${upath}/personal1
sudo rm -rf ${upath}/perosnal2
sudo rm -rf ${upath}/perosnaln
sudo rm -rf /vagrant

sudo dd if=/dev/zero of=/EMPTY bs=1M # write zeros to avail the dynamically allocated memory (bs=blocksize) and save zeros in the directory /EMPTY. 
sudo rm -f /EMPTY # now delete the empty directy. now vm is using the whole memoy allocated when box was resized.
sudo cat /dev/null > ~/.bash_history && history -c && exit
