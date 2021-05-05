#!/bin/bash

cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit 1

TEMP_PATH="$(mktemp -d)"
PATH="${TEMP_PATH}:$PATH"

echo '::group::🐶 Installing reviewdog ... https://github.com/reviewdog/reviewdog'
curl -sfL https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b "${TEMP_PATH}" "${REVIEWDOG_VERSION}" 2>&1
echo '::endgroup::'

echo '::group:: Installing gigi ... https://github.com/budougumi0617/gigi'
curl -L "$(curl -Ls https://api.github.com/repos/budougumi0617/gigi/releases/latest | grep -o -E "https://.+?_Linux_x86_64.tar.gz")" -o gigi.tar.gz && tar -zxvf gigi.tar.gz -C "${TEMP_PATH}" && rm gigi.tar.gz
echo '::endgroup::'

export GIGI_GITHUB_TOKEN="${INPUT_GITHUB_TOKEN}"
export GIGI_MAX_ADDED_COUNT="${INPUT_MAX_ADDED_COUNT}"

echo '::group:: Running gigi ...'
# shellcheck disable=SC2086
gigi
echo '::endgroup::'