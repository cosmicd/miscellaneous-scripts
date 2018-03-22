# useage: . ./filename.ps1
# Before running this script see install/prepare-vbox-creation.sh then:
# 1. run the existing vm
# 2. clean the vm using: . prepare_vbox_creation.sh
# 3. You may have to change boxname below; then source this script: . createbox.ps1
# 4. remove existing vm through virtualbox gui (remove, remove all files) 
#    or delete the vm folder.
# 5. open Vagrantfile and change config.vm.box to new box name; 
#    also you may change the vm name.
# 6. vagrant up
# 7. Now you may comment passwd authetication or use a different vagrant file (change box and machine names)
# 8. you can also delete the older vbox floder in c:/users/username/.vagrant.d/boxes
# WARNING: The original vagrant file of existing vm will be overwritten, so you must keep a copy of the vagrantfile of the existing machine.
$boxname="example-ubuntu-xenial64-v1" # name of the box you want to create
$boxfile=$boxname + ".box"
vagrant package --output "$boxfile"
vagrant box add "$boxname" "$boxfile"
Copy-Item Vagrantfile Vagrantfile2
Remove-Item Vagrantfile
Remove-Item .vagrant
vagrant init "$boxname"
Copy-Item Vagrantfile2 Vagrantfile
Remove-Item Vagrantfile2
