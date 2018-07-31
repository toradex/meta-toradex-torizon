#!/bin/sh

set -o errexit
set -o nounset

DOCKER_TIMEOUT=20 # Wait 20 seconds for docker to start
BUILD=/build

finish() {
	# Make all files owned by the build system
	chown -R "$USER_ID:$USER_GID" "${BUILD}"
}
trap finish EXIT

# Create user
echo "[INFO] Creating and setting $USER_ID:$USER_GID."
groupadd -g "$USER_GID" docker-disk-group || true
useradd -u "$USER_ID" -g "$USER_GID" -p "" docker-disk-user || true

mkdir -p $BUILD/docker

# Start docker
echo "Starting docker daemon with $BALENA_STORAGE storage driver."
dockerd -g $BUILD/docker -s "$BALENA_STORAGE" &
echo "Waiting for docker to become ready.."
STARTTIME="$(date +%s)"
ENDTIME="$STARTTIME"
while [ ! -S /var/run/docker.sock ]
do
    if [ $((ENDTIME - STARTTIME)) -le $DOCKER_TIMEOUT ]; then
        sleep 1 && ENDTIME=$((ENDTIME + 1))
    else
        echo "Timeout while waiting for docker to come up."
        exit 1
    fi
done
echo "Docker started."

# Pull in the image
echo "Pulling ${TARGET_REPOSITORY}:${TARGET_TAG}..."
docker pull "${TARGET_REPOSITORY}:${TARGET_TAG}"

echo "Stopping docker..."
kill -TERM "$(cat /var/run/docker.pid)"
# don't let wait() error out and crash the build if the docker daemon has already been stopped
wait "$(cat /var/run/docker.pid)" || true
