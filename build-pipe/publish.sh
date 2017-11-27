#!/bin/bash
set -ex

TIMESTAMP=`date +'%Y%m%d_%H_%M_%S'`
TIMESTAMP_LONG=`date +'%Y/%m/%d %H:%M:%S'`

ARCHIVE_NAME_JDK="${SAPMACHINE_ARCHIVE_NAME_PREFIX}-${GIT_TAG_NAME}.tar.gz"
ARCHIVE_SUM_JDK="${SAPMACHINE_ARCHIVE_NAME_PREFIX}-${GIT_TAG_NAME}.sha256.txt"
ARCHIVE_FILE_JDK="${SAPMACHINE_ARCHIVE_NAME_PREFIX}-jdk.tar.gz"
ARCHIVE_NAME_JRE="${SAPMACHINE_ARCHIVE_NAME_PREFIX}-${GIT_TAG_NAME}-jre.tar.gz"
ARCHIVE_SUM_JRE="${SAPMACHINE_ARCHIVE_NAME_PREFIX}-${GIT_TAG_NAME}-jre.sha256.txt"
ARCHIVE_FILE_JRE="${SAPMACHINE_ARCHIVE_NAME_PREFIX}-jre.tar.gz"

export GITHUB_TOKEN=$SAPMACHINE_PUBLISH_GITHUB_TOKEN
export GITHUB_USER=$SAPMACHINE_PUBLISH_GITHUB_USER
export GITHUB_REPO=$SAPMACHINE_PUBLISH_GITHUB_REPO_NAME


if [ -z $GIT_TAG_NAME ]; then
  GIT_TAG_NAME="snapshot-${TIMESTAMP}"
  GIT_TAG_DESCRIPTION="Snapshot ${TIMESTAMP_LONG}"
  github-release release -t $GIT_TAG_NAME --pre-release -d "$GIT_TAG_DESCRIPTION"

else
  github-release release -t $GIT_TAG_NAME
fi

mv $ARCHIVE_FILE_JRE $ARCHIVE_NAME_JRE
mv $ARCHIVE_FILE_JDK $ARCHIVE_NAME_JDK

sha256sum ARCHIVE_NAME_JRE > $ARCHIVE_SUM_JRE
sha256sum ARCHIVE_NAME_JDK > $ARCHIVE_SUM_JDK

github-release -v \
    upload \
    -t "${GIT_TAG_NAME}" \
    -n "${ARCHIVE_NAME_JDK}" \
    -f "${ARCHIVE_NAME_JDK}"

github-release -v \
    upload \
    -t "${GIT_TAG_NAME}" \
    -n "${ARCHIVE_NAME_JRE}" \
    -f "${ARCHIVE_NAME_JRE}"

github-release -v \
    upload \
    -t "${GIT_TAG_NAME}" \
    -n "${ARCHIVE_SUM_JRE}" \
    -f "${ARCHIVE_SUM_JRE}"

github-release -v \
    upload \
    -t "${GIT_TAG_NAME}" \
    -n "${ARCHIVE_SUM_JDK}" \
    -f "${ARCHIVE_SUM_JDK}"
