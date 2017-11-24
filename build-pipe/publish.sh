#!/bin/sh
set -ex

TIMESTAMP=`date +'%Y%m%d_%H_%M_%S'`
TIMESTAMP_LONG=`date +'%Y/%m/%d %H:%M:%S'`

if [ -z $GIT_TAG_NAME ]; then
  GIT_TAG_NAME="snapshot-${TIMESTAMP}"
  GIT_TAG_DESCRIPTION="Snapshot ${TIMESTAMP_LONG}"
  GIT_TAG_OPTION="-t $GIT_TAG_NAME -d $GIT_TAG_DESCRIPTION --pre-release"
else
  GIT_TAG_OPTION="-t $GIT_TAG_NAME"
fi

ARCHIVE_NAME_JDK="${SAPMACHINE_ARCHIVE_NAME_PREFIX}-${GIT_TAG_NAME}.tar.gz"
ARCHIVE_FILE_JDK="${SAPMACHINE_ARCHIVE_NAME_PREFIX}-jdk.tar.gz"
ARCHIVE_NAME_JRE="${SAPMACHINE_ARCHIVE_NAME_PREFIX}-${GIT_TAG_NAME}-jre.tar.gz"
ARCHIVE_FILE_JRE="${SAPMACHINE_ARCHIVE_NAME_PREFIX}-jre.tar.gz"

export GITHUB_TOKEN=$SAPMACHINE_PUBLISH_GITHUB_TOKEN
export GITHUB_USER=$SAPMACHINE_PUBLISH_GITHUB_USER
export GITHUB_REPO=$SAPMACHINE_PUBLISH_GITHUB_REPO_NAME


github-release -v \
    release \
    $GIT_TAG_OPTION

github-release -v \
    upload \
    -t "${GIT_TAG_NAME}" \
    -n "${ARCHIVE_NAME_JDK}" \
    -f "${ARCHIVE_FILE_JDK}"

github-release -v \
    upload \
    -t "${GIT_TAG_NAME}" \
    -n "${ARCHIVE_NAME_JRE}" \
    -f "${ARCHIVE_FILE_JRE}"
