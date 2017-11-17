#!/bin/bash

#HG_HOST="hg.openjdk.java.net"
#HG_PATH="jdk/jdk"
HG_HOST="bitbucket.org"
HG_PATH="axel7born/mercurial2git"



GIT_REPO="http://${GIT_USER}:${GIT_PASSWORD}@github.com/axel7born/mercurial2git"

git hg clone "http://$HG_HOST/$HG_PATH"

REPO_PATH="$(basename $HG_PATH)"
cd $REPO_PATH

git remote add origin $GIT_REPO
git checkout -b "$HG_PATH"

git push origin "$HG_PATH"
