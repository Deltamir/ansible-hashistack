#!/usr/bin/env bash

function log_info() {
  >&2 echo -e "[\\e[1;94mINFO\\e[0m] $*"
}

function log_warn() {
  >&2 echo -e "[\\e[1;93mWARN\\e[0m] $*"
}

function log_error() {
  >&2 echo -e "[\\e[1;91mERROR\\e[0m] $*"
}

# check number of arguments
if [[ "$#" -lt 1 ]]; then
  log_error "Missing arguments"
  log_error "Usage: $0 <next version> "
  exit 1
fi

nextVer=$1

log_info "Pushing tags..."
curl -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer ${GITHUB_COM_TOKEN}" -H "X-GitHub-Api-Version: 2022-11-28"  -d "{\"tag_name\":\"${nextVer}\",\"target_commitish\":\"main\",\"name\":\"Release ${nextVer}\",\"draft\":false,\"prerelease\":false,\"generate_release_notes\":false}" "https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases"