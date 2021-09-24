#!/usr/bin/env bash

set -e

# OSX GUI apps do not pick up environment variables the same way as Terminal apps and there are no easy solutions,
# especially as Apple changes the GUI app behavior every release (see https://stackoverflow.com/q/135688/483528). As a
# workaround to allow GitHub Desktop to work, add this (hopefully harmless) setting here.
export PATH=$PATH:/usr/local/bin

# Store and return last failure from validate so this can validate every directory passed before exiting
VALIDATE_ERROR=0

for file in "$@"; do
  echo "--> Running 'packer validate -syntax-only' on file '$file'"
  pushd "$(dirname "$file")" >/dev/null
  packer validate -syntax-only "$(basename "$file")"
  popd >/dev/null
done

exit ${VALIDATE_ERROR}
