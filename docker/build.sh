#!/bin/bash
# https://claude.ai/chat/53c7ac9b-d91a-4837-adad-0ff119ac5ae8

pushd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null || exit

[[ -n ${1} ]] &&
  	tagArgs=" -t ${1} "

# shellcheck disable=SC2086
docker build --build-arg NB_USER="$(whoami)" --build-arg NB_UID="$(id -u)" \
  ${tagArgs} .

popd >/dev/null || exit
