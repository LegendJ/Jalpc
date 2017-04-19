#!/bin/bash
jekyll build
git add --all
git commit -m 'upload'
git push origin master
