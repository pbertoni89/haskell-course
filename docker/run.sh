#!/bin/bash
# https://claude.ai/chat/53c7ac9b-d91a-4837-adad-0ff119ac5ae8

thisDir="$(dirname "${BASH_SOURCE[0]}")"
gitDir="${thisDir}"/..

function run_without_compose()
{
  set -x
  containerId=$(docker run -it -d --rm \
    -v "${gitDir}":/home/jovyan/git -p 8888:8888 \
    pbertoni/haskell:latest \
    jupyter lab --ip=0.0.0.0 --no-browser)

  sleep 5

  set -x
  docker logs "${containerId}" | tail -1 | tee "${thisDir}"/url.txt
  { set +x; } 2> /dev/null
}


function run_with_compose()
{
  set -x
  local composeFile="${thisDir}/compose.yaml"
  local projectName="hs"

  docker compose -f "${composeFile}" --project-name hs down

  # Tear down any previous project and bring up fresh
  docker compose -f "${composeFile}" --project-name "${projectName}" down
  docker compose -f "${composeFile}" --project-name "${projectName}" up -d

  # Give compose a moment to create containers
  sleep 2

  # Try to get the container id for the `jupyter` service using the same project name
  containerId=$(docker compose -f "${composeFile}" --project-name "${projectName}" ps -q jupyter 2>/dev/null)

  # Give the container time to start
  sleep 5

  set -x
  docker logs "${containerId}" | tail -1 | tee "${thisDir}"/url.txt
  { set +x; } 2> /dev/null
}

run_with_compose
