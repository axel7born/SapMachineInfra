#!/bin/bash
set -ex

wget https://github.com/AdoptOpenJDK/openjdk9-releases/releases/download/jdk-9%2B181/OpenJDK9_x64_Linux_jdk-9.181.tar.gz
tar zxvf OpenJDK9_x64_Linux_jdk-9.181.tar.gz

git clone "http://axel7born:$GITHUB_TOKEN@github.com/SAP/SapMachine"
cd SapMachine
git checkout $TAG

bash configure --with-boot-jdk="/openjdk/build/jdk-9+181/"

make images

tar zcvf SapMachine.tgz build/linux-x86_64-normal-server-release/images/jdk/

wget https://github.com/aktau/github-release/releases/download/v0.7.2/linux-amd64-github-release.tar.bz2

bunzip2 linux-amd64-github-release.tar.bz2
tar xvf linux-amd64-github-release.tar

export PATH=$PWD/bin/linux/amd64/:$PATH

if [ -z $GITHUB_TOKEN ]; then
  echo "FAILURE: GITHUB_TOKEN not set"
  exit 1
fi

#TODO. check if tag exists

github-release release -u SAP -r SapMachine -t $TAG
github-release upload -u SAP -r SapMachine -t $TAG -n SapMachine.tgz -f SapMachine.tgz
