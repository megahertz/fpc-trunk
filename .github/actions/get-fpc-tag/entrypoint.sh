#!/bin/sh

set -e

env


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
  #local revision; revision="$(get_fpc_revision)"
  #local version; version="$(get_fpc_version)"
  #local tag="${version}-${revision}"

  echo "repo: ${INPUT_SVN_REPOSITORY}"
}
