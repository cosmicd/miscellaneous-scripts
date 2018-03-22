# useage: . ./resize-vbox.ps1
# Purpose: Resize existing vbox disc.
# This step has to be performed on the box. If you already have a vm, 
# it may not work. Just delete the newly created vm, resized the box, 
# and created a new vm.
# This script works on windows 7 with ubuntu-xenial guest. It resizes 
# the disc of the vm; change the paths and the size as needed. If the 
# process works, you may delete the cloned vdi and the copied original vmdk.
Clear-Host
# if vboxmanage command is not found, uncomment the following to temporarily add the path:
# $env:path = $env:path+ ";" + "C:\Program Files\Oracle\VirtualBox\"
$boxpath = "C:\Users\username\.vagrant.d\boxes\ubuntu-VAGRANTSLASH-xenial64\20171107.2.0\virtualbox\"
$boxvmdk = "ubuntu-xenial-16.04-cloudimg.vmdk"
$boxvdi = "ubuntu-xenial-16.04-cloudimg.vdi"
$newsizeMB = 50240 # around 50 GB

# no need to change anything below
$v1 = $boxpath + $boxvmdk
$v2 = $boxpath + $boxvdi
$v3 = $boxpath +  "Original-"+ $boxvmdk # for a copy of the original box

VBoxManage clonehd $v1 $v2 --format vdi 
Copy-Item $v1 $v3 # just to keep a copy; you may delete it after everything works
VBoxManage modifyhd $v2 --resize $newsizeMB 
VBoxManage clonehd $v2 $v1 --format vmdk

