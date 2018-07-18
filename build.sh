#!/usr/bin/env bash

read_revision() {
  local revision

  if [ -f "CHANGELOG" ]; then
    revision=$(cat CHANGELOG | head -n 1)
  fi

  if [[ ! "${revision}" =~ "[0-9]+" ]]; then
    revision="HEAD"
  fi

  echo revision
}

docker build . \
  -t megahertz/fpc-trunk \
  --no-cache \
  --build-arg PREVIOUS_REVISION="$(read_revision)"

docker run megahertz/fpc-trunk cat /usr/lib/fpc/CHANGELOG > CHANGELOG
version="$(docker run megahertz/fpc-trunk fpc -iV)"
revision="$(read_revision)"

git tag "${version}-${revision}"
git add CHANGELOG
git commit -m "Build ${version}-${revision}"
git push "${version}-${revision}"
git push
