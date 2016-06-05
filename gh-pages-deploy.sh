#!/bin/bash
cd build
git init
git config user.name "travis"
git config user.email "travis@email.com"
git add .
git commit -m "Deployed to Github Pages"
git push --force --quiet "https://${GH_TOKEN}@github.com/mxklb/xamblog2016" master:gh-pages > /dev/null 2>&1
