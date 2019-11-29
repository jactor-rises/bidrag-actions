#!/bin/bash

if [ ! -f .semantic-release-version ]
  then
    >&2 echo no .semantic-release-version found!
    exit 1;
fi

SEMANTIC_RELEASE_VERSION="$(cat .semantic-release-version)"               # the semantic release version to deploy
RELEASE_TABLE="$(cat README.md | grep '|' )"                              # the release table in the changelog file
COUNT="$(echo "$RELEASE_TABLE" | grep -c "$SEMANTIC_RELEASE_VERSION")"    # count all mentions of 'SEMANTIC_RELEASE_VERSION' in the RELEASE_TABLE

echo "echo Found $COUNT mentioning(s) of $SEMANTIC_RELEASE_VERSION in $CHANGELOG_FILE."

if [ $COUNT -lt 1 ]
  then
    echo This artifact is not eligable for auto deployment
    touch .is-not-release-candidate
    exit 0;
fi

echo This artifact is eligable for auto deployment
touch .is-release-candidate
