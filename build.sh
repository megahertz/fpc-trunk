#!/usr/bin/env bash

DOCKER_REPO="megahertz/fpc-trunk"
REPO_URL="https://svn.freepascal.org/svn/fpc/trunk"
VERSION="3.1.1"

set -e

docker_build_and_publish() {
  local repo="$1"
  local tag="$1"
  docker build -t "${repo}:${tag}"
  echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
  docker push "${repo}:${tag}"
}

get_fpc_revision() {
  svn info ${REPO_URL} --show-item revision | tail -n 1
}

get_fpc_version() {
 curl "${REPO_URL}/Makefile.fpc" \
   | grep version= \
   | head -n 1 \
   | sed -E 's/version=([0-9.]+)/\1/'
}

main() {
  local revision; revision="$(get_fpc_revision)"
  local version; version="$(get_fpc_version)"
  local tag="${version}-${revision}"

  docker_build_and_publish "${DOCKER_REPO}" "${tag}"
}

main
