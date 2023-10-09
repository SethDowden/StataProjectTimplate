#!/bin/bash

if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: This script is intended to be run from within Timplate git repository."
    exit 1
fi

echo "WARNING:"
echo "This script will delete the current git repository and reinitialize it with a blank README.MD and a 'main' branch. If you have any uncommitted changes, they will be lost."
read -p "Do you wish to continue? (y/n): " confirm

if [ "$confirm" != "y" ]; then
    echo "Exiting without making changes."
    exit 0
fi

cd "$(git rev-parse --show-toplevel)"

rm -rf .git
git init
git branch -m main

rm README.md
touch README.md

if [ ! -d "venv" ]; then
    echo "Setting up a virtual environment..."
    python3 -m venv venv
    source venv/bin/activate

    echo "Installing necessary Python packages from requirements.txt..."
    if [ -f requirements.txt ]; then
        pip install -r requirements.txt
    else
        echo "requirements.txt not found."
    fi
else
    echo "Virtual environment 'venv' already exists."
fi

echo "Initialization complete! git repository reinitialized with 'main' branch."
echo "👍"

exit 0
