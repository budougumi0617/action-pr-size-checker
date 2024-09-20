#!/bin/bash

cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit 1

TEMP_PATH="$(mktemp -d)"
PATH="${TEMP_PATH}:$PATH"

echo '::group:: Installing gigi ... https://github.com/budougumi0617/gigi'
echo "info: $(curl -Ls https://api.github.com/repos/budougumi0617/gigi/releases/latest | grep html_url.*tag)"
curl -L "$(curl -Ls https://api.github.com/repos/budougumi0617/gigi/releases/latest | grep -o -E "https://.+?_linux_amd64.tar.gz")" -o gigi.tar.gz && tar -zxvf gigi.tar.gz -C "${TEMP_PATH}" && rm gigi.tar.gz
echo '::endgroup::'

export GIGI_GITHUB_TOKEN="${INPUT_GITHUB_TOKEN}"
export GIGI_MAX_ADDED_COUNT="${INPUT_MAX_ADDED_COUNT:-500}"
export GIGI_FILTER_PATTERN="${INPUT_FILTER_PATTERN}"

echo '::group:: Running gigi ...'
# shellcheck disable=SC2086
gigi
status=$?
echo '::endgroup::'
exit $status

