#!/bin/bash

echo "Checking for tabs in project."

#### Config
FILE_TYPES="html|erb|rb|js" # Set all the file extensions that should be checked here.
IGNORE_DIRECTORIES=( "./vendor" "./coverage" ) # Set all the directories that should be ignored here.
#### End Config

function join_by { local d=$1; shift; echo -n "'$1'"; shift; printf "%s'" "${@/#/$d}"; }

IGN_DIRS=""
if [ ${#IGNORE_DIRECTORIES[@]} -eq 0 ]; then
  IGN_DIRS="'./sa3dfjkhasdfiaef8dsfadssensoifahsn3'"
else
  IGN_DIRS="$(join_by " -or -path '" "${IGNORE_DIRECTORIES[@]}")"
fi

if [ -n "$IGN_DIRS" ]; then
  IGN_DIRS="-path ${IGN_DIRS}"
fi

echo "Checking file types: $FILE_TYPES"
echo ""

OFFENDERS=""
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  CMD="find -regextype posix-extended -regex \".*\.($FILE_TYPES)\" -or \( $IGN_DIRS \) -prune -type f | xargs grep -n -e $'\t'"
  OFFENDERS="eval $($CMD)"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  CMD="find -E . -iregex \".*\.($FILE_TYPES)\" -or \( $IGN_DIRS \) -prune -type f | xargs grep -n -e $'\t'"
  echo $CMD
  OFFENDERS="$(bash -c "$CMD")"
fi

if [ -n "$OFFENDERS" ]; then
    echo "$OFFENDERS"
    echo ""
    echo "Error. Found $(echo "$OFFENDERS" | wc -l | xargs) lines with tabs..."
    exit 1
else
    echo "No tabs found. Check complete."
fi

