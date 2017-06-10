#!/bin/bash

#$1 module name
#$2 username
#$3 directory
#$4 owner optional

cd $3
git clone git@192.168.210.103:$1
[[ $? -ne 0 ]] && exit 1

cd $1

if [ "$4" != "" ]; then
    /opt/pehu/bin/pehu-modcreate $3 $1 normal
    git add --all
   
    touch $1.json
    echo "{\"name\":$1, \"resources\":[], \"models\":[] }" >> $1.json
    git add $1.json
    git commit -m "module object"
    git push
fi

git branch $2
git checkout $2 
