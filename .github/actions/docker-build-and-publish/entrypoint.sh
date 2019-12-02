#!/bin/sh

set -e

main() {
  local repo="${INPUT_DOCKER_REPOSITORY}"
  local tag="${INPUT_DOCKER_TAG}"
  local user="${INPUT_DOCKER_USERNAME}"
  local pass="${INPUT_DOCKER_PASSWORD}"

  docker build -t "${repo}:${tag}"
  echo "${pass}" | docker login -u "${user}" --password-stdin
  docker push "${repo}:${tag}"
}

main
