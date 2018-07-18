#!/usr/bin/env bash

REPO_URL="https://svn.freepascal.org/svn/fpc/trunk"
VERSION="3.1.1"

set -e

read_revision() {
  local revision

  if [ -f "CHANGELOG" ]; then
    revision=$(cat CHANGELOG | head -n 1)
  fi

  if [[ ! "${revision}" =~ "[0-9]+" ]]; then
    revision="HEAD"
  fi

  echo "${revision}"
}

old_revision="$(read_revision)"
new_revision="$(svn info ${REPO_URL} --show-item revision | tail -n 1)"

if [ "${old_revision}" == "${new_revision}" ]; then
  echo "There are no new revisions in trunk"
  exit 0
fi

echo "${new_revision}" > CHANGELOG
svn log ${REPO_URL} -r ${old_revision}:HEAD | tail -n 50 >> CHANGELOG

git tag "${VERSION}-${new_revision}" || true
git add CHANGELOG
git commit -m "Build ${VERSION}-${new_revision}"
git push origin "${VERSION}-${new_revision}"
git push origin master
