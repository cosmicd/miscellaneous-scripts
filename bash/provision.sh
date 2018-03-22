#!/bin/bash
# Pupose: Script used to provision the vagrant vm. 

doall(){ 
    cleanup
    buildreq
    pythontools
    nodetools 
    misc
}

cleanup(){
apt-get clean all && apt-get autoclean && apt-get update && apt-get upgrade && apt-get -y autoremove
}

buildreq(){
# dev tools
apt-get install -y python3-software-properties
# common python build tools suggested at https://github.com/pyenv/pyenv/wiki/Common-build-problems
apt-get install -y git make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm-4.0 libncurses5-dev libncursesw5-dev \
xz-utils tk-dev
}

pythontools(){
pwd # this gives /home/ubuntu 
echo ${HOME} # this gives /root; vagrant is provisioning with /root as user; hence any software that tries to install itself in $HOME, will go to /root.
export PYENV_ROOT=$(pwd)"/.pyenv" # otherwise installation goes to /root
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
chown -R ubuntu.ubuntu ${PYENV_ROOT} # change the ownership of the dir, recursively, from root to ubuntu user
echo 'export PATH="${HOME}/.pyenv/bin":$PATH' >> .profile
echo 'eval "$(pyenv init -)"' >> .profile
echo 'eval "$(pyenv virtualenv-init -)"' >> .profile
}

nodetools(){
# node_n # use n or nvm below
node_nvm 
}

misc(){
sudo apt-get install -y unzip
# WARN: time synchornization is givving problems; just reload the vm if aws compains.
sudo apt-get install -y ntp # then use sudo timedatectl set-ntp on to synchronize time after logging in.

}
node_nvm(){ 
sudo curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
}
node_n(){ 
pwd
# runs from home/username
npath=$(pwd)"/n"
# this will install n and stable node version. for details, see https://github.com/mklement0/n-install
sudo curl -L https://git.io/n-install | N_PREFIX=${npath} bash -s -n -- -y # comment from n git repo: After switching Node.js versions using n, npm may not work properly. This should fix it (thanks @mikemoser!): $ curl -0 -L https://npmjs.com/install.sh | sh  
chown -R ubuntu.ubuntu ${npath} # change the ownership of the dir, recursively, from root to ubuntu user
echo 'export N_PREFIX='${npath} >> .profile
echo '[[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"' >> .profile 
}
$@ 