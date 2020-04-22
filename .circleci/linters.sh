#!/usr/bin/env bash
set -exu

go get -v -u github.com/golangci/golangci-lint/cmd/golangci-lint
go install github.com/golangci/golangci-lint/cmd/golangci-lint
cd "${CIRCLE_WORKING_DIRECTORY}"
golangci-lint run --enable deadcode --enable varcheck --enable staticcheck

# check license headers
# this needs to be run from the top level directory, because it uses
# `git ls-files` under the hood.
go get -v -u github.com/u-root/u-root/tools/checklicenses
go install github.com/u-root/u-root/tools/checklicenses
cd "${CIRCLE_WORKING_DIRECTORY}"
echo "[*] Running checklicenses"
go run github.com/u-root/u-root/tools/checklicenses -c .circleci/config.json