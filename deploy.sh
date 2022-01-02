#!/usr/bin/env sh

# abort on errors
set -e

# build
npm run build

# navigate into the build output directory
cd dist

git init
git add -A
git commit -m 'Deployment'

# if you are deploying to https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:Coding-Fibre/recursive-menu.git master:gh-pages

cd -