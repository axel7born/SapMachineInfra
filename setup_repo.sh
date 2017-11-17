#!/bin/bash

HG_HOST="hg.openjdk.java.net"
HG_PATH="jdk/jdk"
#HG_HOST="bitbucket.org"
#HG_PATH="axel7born/mercurial2git"

GIT_REPO="http://${GIT_USER}:${GIT_PASSWORD}@github.com/axel7born/SapMachine"

git hg clone "http://$HG_HOST/$HG_PATH"

REPO_PATH="$(basename $HG_PATH)"
cd $REPO_PATH

git remote add origin $GIT_REPO

# save .hg dir
git checkout -b hg-info
rm .git
mv .hg/git .git
git add -f .hg
git commit -m "Add .hg dir"
git push origin hg-info

git checkout master
git checkout -b "$HG_PATH"
git push origin "$HG_PATH"
