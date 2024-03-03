# #!/bin/bash


commit_hash=$(git log -1 --pretty=format:'%h')
commit_titlr=$(git log -1 --pretty=format:'%s')
commit_author=$(git log -1 --pretty=format:'%an')
commit_description=$(git log -1 --pretty=format:'%b')

commit_url=$(git remote -v | grep origin | grep fetch | sed -E 's/^.*github.com[:/](.*)(\.git).*$/https:\/\/github.com\/\1\/commit\/'$commit_hash'/')


messages_until_last_commit="$commit_titlr $commit_description"
messages_until_last_commit=$(echo $messages_until_last_commit | tr '[:upper:]' '[:lower:]')

key_major=$(echo "BREAKING CHANGES:" | tr '[:upper:]' '[:lower:]')
key_minor=$(echo "FEATURES:" | tr '[:upper:]' '[:lower:]')
key_patch=$(echo "FIXES:" | tr '[:upper:]' '[:lower:]')

mdTag="## MINOR FIXES"

if [[ $messages_until_last_commit == *"$key_major"* ]]; then
mdTag="## BREAKING CHANGES"
elif [[ $messages_until_last_commit == *"$key_minor"* ]]; then
mdTag="## FEATURES"
elif [[ $messages_until_last_commit == *"$key_patch"* ]]; then
mdTag="## FIXES"
fi






cp CHANGELOG.md temp_changelog.md

new_content="$mdTag
- Title: $commit_titlr
- Description: $commit_description
- Date: $(date +'%d.%m.%Y')
- Version: $1
- Author: ([$commit_author]($commit_url))

"

echo "$new_content$(cat temp_changelog.md)" > CHANGELOG.md

rm temp_changelog.md