#!/bin/bash

#$1 module name
#$2 local modules directory
#$3 user
#$4 commit message

cd $2/$3/$1

git add --all
git commit -m "$4" 


