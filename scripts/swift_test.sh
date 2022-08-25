#!/bin/bash

# Set our output directory. If none is set, use the DEPLOY_DIRECTORY environment variable by default.
output_directory=${1-$DEPLOY_DIRECTORY}

# If output_directory is set, use it and gather code coverage,
# copying the output to the directory.
# Otherwise, just run the test.
if [ ! -z $output_directory ]; then
    mkdir -p $output_directory

    swift test -c debug --enable-code-coverage --enable-test-discovery
    cp $(swift test --show-codecov-path) "${output_directory}/codecov.json"
else
    swift test -c debug --enable-test-discovery
fi
