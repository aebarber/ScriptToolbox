#!/bin/bash

git filter-branch --tree-filter 'rm -rf node_modules' --prune-empty HEAD
git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
echo node_modules/ >> .gitignore
git add .gitignore
git commit -m 'Removing node_modules from git history'
git gc
git push origin master --force
