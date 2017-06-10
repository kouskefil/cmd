#!/bin/bash

#$1 module dir
#$2 commit message

cd $1

git add --all
git commit -m "$2" 


