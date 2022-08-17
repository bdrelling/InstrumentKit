#!/bin/bash

mkdir -p $DEPLOY_DIRECTORY

swift test -c debug --enable-code-coverage
cp $(swift test --show-codecov-path) "${DEPLOY_DIRECTORY}/codecov.json"
