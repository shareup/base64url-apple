#!/usr/bin/env bash

set -eo pipefail

if [[ -z $(command -v swiftformat) ]]; then
  echo "warning: Install swiftformat by running 'brew install swiftformat'"
  exit 1
fi

swiftformat .
