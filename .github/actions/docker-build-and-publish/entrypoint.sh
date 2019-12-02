#!/bin/sh

if [ -n "${INPUT_DEBUG}" ]; then
  set -ex
else
  set -e
fi

main() {
  local repo="${INPUT_REPOSITORY}"
  local tag="${INPUT_TAG}"
  local user="${INPUT_USERNAME}"
  local pass="${INPUT_PASSWORD}"

  docker build -t "${repo}:${tag}"
  echo "${pass}" | docker login -u "${user}" --password-stdin
  docker push "${repo}:${tag}"
}

main
