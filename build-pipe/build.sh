#!/bin/sh

if [ -d SapMachine ]; then
    rm -rf SapMachine;
fi

git clone -b $SAPMACHINE_GIT_BRANCH $SAPMACHINE_GIT_REPO SapMachine
cd SapMachine
bash ./configure --with-boot-jdk=$BOOT_JDK
make JOBS=12 images

cd build
cd `ls`/images

tar czf ../../../../"${SAPMACHINE_ARCHIVE_NAME_PREFIX}-jdk.tar.gz" jdk
tar czf ../../../../"${SAPMACHINE_ARCHIVE_NAME_PREFIX}-jre.tar.gz" jre
