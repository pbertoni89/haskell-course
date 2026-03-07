#!/bin/bash
# https://claude.ai/chat/53c7ac9b-d91a-4837-adad-0ff119ac5ae8

gitDir="$(dirname "${BASH_SOURCE[0]}")"

set -x

containerId=$(docker run -it -d --rm \
	-v "${gitDir}":/home/jovyan/git -p 8888:8888 \
	pbertoni/haskell:latest \
	jupyter lab --ip=0.0.0.0 --no-browser)

sleep 5

set -x
docker logs "${containerId}" | tail -1 | tee "${gitDir}"/url.txt
set +x

{ set +x; } 2> /dev/null
