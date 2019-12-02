#!/bin/sh

[ -n "${INPUT_DEBUG}" ] && set -ex || set -e

REPO_URL="${INPUT_SVN_REPOSITORY:-https://svn.freepascal.org/svn/fpc/trunk}"

get_fpc_revision() {
  svn info ${REPO_URL} --show-item revision | tail -n 1
}

get_fpc_version() {
 wget -O - "${REPO_URL}/Makefile.fpc" \
   | grep version= \
   | head -n 1 \
   | sed -E 's/version=([0-9.]+)/\1/'
}

main() {
  local revision; revision="$(get_fpc_revision)"
  local version; version="$(get_fpc_version)"
  echo "::set-output name=revision::${revision}"
  echo "::set-output name=version::${version}"
  echo "::set-output name=tag::${version}-${revision}"
}

main
