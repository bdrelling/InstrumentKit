#!/bin/bash

# Verify the script has been executed
echo "Installing git hooks..."

# if there are any scripts in the scripts/git-hooks folder,
# copy them into the .git/hooks folder which is not source controlled
# This will replace any existing files
cp -R -a scripts/git-hooks/. .git/hooks

# Verify the script has completed
echo "Git hooks installed."
