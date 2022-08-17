#!/bin/bash

# Verify the script has been executed
echo "Running setup script..."

# 1 - Install and Verify Build Tools

# ensure that homebrew is installed
# TODO: Add check for version of homebrew
command -v brew >/dev/null 2>&1 || {
    echo >&2 "Homebrew is not installed."
    exit 1
}

# ensure that mint is installed
# TODO: Add check for version of mint
command -v mint >/dev/null 2>&1 || {
    echo >&2 "Mint is not installed."
    exit 1
}

# 2 - Install Git Hooks

# if there are any scripts in the scripts/git-hooks folder,
# copy them into the .git/hooks folder which is not source controlled
# This will replace any existing files
scripts/install_git_hooks.sh

# Verify the script has completed
echo "Setup complete."
