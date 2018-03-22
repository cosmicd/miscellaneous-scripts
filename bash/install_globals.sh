#!/bin/bash
# Purpose: install global tools on linux system (tested on ubuntu-xenial).
pyv="3.6.3" # python version for global useage
nv="9.0.0" # node version for global useage

doall(){ 
    docker_setup
    python_globals
    node_globals
}

docker_setup(){
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
sudo apt-get update && sudo apt-get install -y docker-ce && sudo docker run hello-world

#sudo groupadd docker # if the group does not exist uncomment this
uname='ubuntu';sudo usermod -aG docker $uname # This step allows the following to run without sudo if you logout and login again. sam-local wouldnt work without this step.
docker run hello-world
}

python_globals(){
#PYENV
pyenv install $pyv # install a version 
echo 'pyenv global' $pyv >> .profile # add this to .profile to always use the same python globally
. .profile
sudo apt install virtualenv # although pyenv has a virtualenv wrapper, plain virtualenv is another option.

#AWS
# you should have python installed and set the global python using 'pyenv global pythonversion' (confirm it is done in .profile)
pip install awscli --upgrade --user && complete -C '${HOME}/.local/bin/aws_completer' aws
pip install cfn-flip # a cli utility to convert cloudformation json templates to yml 
}

node_globals(){
n $nv
npm install -g npm-check-updates \
               aws-sam-local \ #requires docker; if docker is installed, sam-local auto-pulls images.
               awsmobile-cli \               
               create-react-app \
               @storybook/cli \
               serverless \
              # preact-cli \               
              # vue-cli
}
$@ 