#!/bin/bash

NAME="Jane Doe"
OUT_FILE_PEFIX="Jane_Doe"
FLAG="-e"
STATA="/Applications/Stata/StataBE.app/Contents/MacOS/StataBE"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_DIR="logs"

if [[ "$1" =~ ^(-h|-H|-help|help|h)$ ]]; then
  echo -e "Usage: stata [-option [-option [...]]] [stata_command]\n"
  echo -e "Available Flags:"
  echo -e "\t-q\tSuppress initialization messages"
  echo -e "\t-b\tSet background (batch) mode and log in ASCII text"
  echo -e "\t-e\tSet background (batch) mode and log in ASCII text and exit without prompting when Stata command is completed"
  echo -e "\t-s\tSet background (batch) mode and log in SMCL"
  exit 0
fi

if [[ -z "$1" && -f "main.do" ]]; then
  IN_FILE="main.do"
elif [[ "$1" =~ ^- && -n "$2" ]]; then
  IN_FLAG="$1"
  IN_FILE="$2"
elif [[ ! "$1" =~ ^- && -n "$1" ]]; then
  IN_FILE="$1"
else
  echo "Error: Invalid input. Use -h for help."
  exit 1
fi

mkdir -p "$LOG_DIR" # ensure the logs folder exists
BASENAME=$(basename "$IN_FILE" .do)
DO_FILE="${OUT_FILE_PEFIX}_${BASENAME}.do"
LOGFILE="${OUT_FILE_PEFIX}_${BASENAME}.log"

cp $IN_FILE "$LOG_DIR/$DO_FILE"

cat <<EOT >"$LOG_DIR/$DO_FILE"
*------------------------------------------------------------------------------* 
* Author: ${NAME}
* Date: $(date "+%B %-d, %Y")
* Project: ${BASENAME}
*------------------------------------------------------------------------------*
* Initalize Stata environment.
clear all
set more off
set seed 42
cd $(pwd)

EOT

cat "$IN_FILE" >>"$LOG_DIR/$DO_FILE"

cat <<EOT >>"$LOG_DIR/$DO_FILE"

*✌️j
EOT

cd "$LOG_DIR"

"$STATA" "$FLAG" do "\"$DO_FILE\"" && bat --wrap=never $LOGFILE

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git add .

  if git diff-index --quiet HEAD --; then
    echo "No changes to commit."
  else
    if [ "$(git rev-list --count HEAD)" -eq "1" ]; then
      git commit -m "${TIMESTAMP} (second commit)"
    elif ! git rev-parse HEAD >/dev/null 2>&1; then
      git commit -m "${TIMESTAMP} (initial commit)"
    else
      ADDED=$(git diff HEAD~1 --shortstat | awk '{print $4}')
      REMOVED=$(git diff HEAD~1 --shortstat | awk '{print $6}')
      git commit -m "STATA Auto (+${ADDED}/-${REMOVED} lines)"
    fi
  fi
  echo "Suceessfully committed changes to Git. 🎉"
else
  echo "Not a Git repository. No changes committed. 😢"
fi