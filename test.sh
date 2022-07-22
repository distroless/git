#!/usr/bin/env bash

set -o errexit -o nounset -o errtrace -o pipefail

IMAGE_NAME=${IMAGE_NAME:-"distroless.dev/git"}
CLONE_URL=${CLONE_URL:-"https://github.com/distroless/git.git"}

CLONEDIR="$(mktemp -d)"
chmod go+wrx "${CLONEDIR}"
trap "rm -rf ${CLONEDIR}" EXIT

# Try cloning a repo and check for README.md
pushd "${CLONEDIR}"
docker run --rm -v "${PWD}":/w -w /w $IMAGE_NAME clone --depth 1 $CLONE_URL .
find README.md
popd
