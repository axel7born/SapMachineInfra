#!/bin/bash
set -ex

HG_HOST="hg.openjdk.java.net"
HG_PATH="jdk/jdk"
#HG_HOST="bitbucket.org"
#HG_PATH="axel7born/mercurial2git"


GIT_REPO="http://${GIT_USER}:${GIT_PASSWORD}@github.com/axel7born/SapMachine"

git clone $GIT_REPO

REPO_PATH="$(basename $GIT_REPO)"
cd $REPO_PATH

#get hg info
git checkout hg-info
mv .git .hg/git
ln -s .hg/git .git

git rm --cached -r .hg
git commit -m "remove .hg from git"

git checkout master
git hg pull

git checkout -b "$HG_PATH"
git rebase master

git push origin "$HG_PATH"

git checkout hg-info
rm .git
mv .hg/git .git
git add -f .hg
git commit -m "Add .hg dir"
git push origin hg-info
