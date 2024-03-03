#! /bin/bash

RE='([0-9]+)\.([0-9]+)\.([0-9]+)\+?([0-9]+)?'

lastVersion="$1"

if [ -z "$2" ]
then
  nextVersion=$lastVersion
else
  nextVersion="$2"
fi

LAST_UAT_BUILD_NUMBER=`echo $lastVersion | sed -E "s/$RE/\4/"`

NEXT_VERSION_MAJOR=`echo $nextVersion | sed -E "s/$RE/\1/"`
NEXT_VERSION_MINOR=`echo $nextVersion | sed -E "s/$RE/\2/"`
NEXT_VERSION_PATCH=`echo $nextVersion | sed -E "s/$RE/\3/"`


commit_titlr=$(git log -1 --pretty=format:'%s')
commit_description=$(git log -1 --pretty=format:'%b')


messages_until_last_commit="$commit_titlr $commit_description"
messages_until_last_commit=$(echo $messages_until_last_commit | tr '[:upper:]' '[:lower:]')

key_major=$(echo "BREAKING CHANGES:" | tr '[:upper:]' '[:lower:]')
key_minor=$(echo "FEATURES:" | tr '[:upper:]' '[:lower:]')
key_patch=$(echo "FIXES:" | tr '[:upper:]' '[:lower:]')

if [[ $messages_until_last_commit == *"$key_major"* ]]; then
    ((NEXT_VERSION_MAJOR++))
    NEXT_VERSION_MINOR=0
    NEXT_VERSION_PATCH=0
elif [[ $messages_until_last_commit == *"$key_minor"* ]]; then
    ((NEXT_VERSION_MINOR++))
    NEXT_VERSION_PATCH=0
elif [[ $messages_until_last_commit == *"$key_patch"* ]]; then
    ((NEXT_VERSION_PATCH++))
fi


((LAST_UAT_BUILD_NUMBER++))
echo "$NEXT_VERSION_MAJOR.$NEXT_VERSION_MINOR.$NEXT_VERSION_PATCH+$LAST_UAT_BUILD_NUMBER"