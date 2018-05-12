#!/bin/bash

set -e

git stash
npm run build

if [[ $TRAVIS && $(git diff) ]]; then
    printf "\n\n"
    echo "There seem to be changes after running the code generation."
    echo "This might be because you updated a native dependency and forgot to run the code generation."
    echo "If this is the case run 'cd generation && npm run build'"
    printf "\n"
    echo "Another source of this error might be that you have changed generated code and checked it in."
    echo "You should not be doing this, please change the source of the generated code and not the code itself."
    printf "\n"
    echo "$(git diff)"
    git stash pop
    exit 1
else
    git stash pop
fi