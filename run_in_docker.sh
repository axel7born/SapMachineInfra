#!/bin/bash
set -e

CURRENT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

SCRIPT="$CURRENT_DIRECTORY/$1"
CONTAINER_NAME="$JOB_NAME"

ADDITIONAL_ENVS=()

while [[ $# -gt 1 ]]
do
  ADDITIONAL_ENVS+=(-e)
  ADDITIONAL_ENVS+=("$2")
  shift 1
done

docker rm -f "$CONTAINER_NAME" || echo "Docker container $CONTAINER_NAME is already deleted"

docker build -t $JOB_NAME $CURRENT_DIRECTORY

# clean up system (stopped containers, volumes, dangling images)
docker system prune --volumes -f || docker system prune -f || true # allow to fail

# store the script's actual output in a file whose name can be passed in through RESULT_FILE
OUT_FILE=${OUT_FILE:-"/dev/null"}
# preserve exit code of 'docker run' below although result is piped to 'tee'
set -o pipefail

# run script
# the following environment variables are passed to the container
# $GIT_USER - the git user to use
# $GIT_PASSWORD - the git password to use
cat "$SCRIPT" | docker run  "${ADDITIONAL_ENVS[@]/#/}" \
  -e "GIT_USER=$GIT_USER" -e "GIT_PASSWORD=$GIT_PASSWORD" \
  -i --name "$CONTAINER_NAME" "$JOB_NAME" /bin/bash - \
| tee "$OUT_FILE"
set +o pipefail

# remove container
docker rm -f "$CONTAINER_NAME" &> /dev/null
