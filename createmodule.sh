#!/bin/bash

# $1 : module name
# $2 : local modules directory
# $3 : work directory (temporary directory)
# $4 : user 

#creating module directory (mod_dir) in tmp dir
if [ -d $3 ]; then
    mkdir $3/$1
else
    echo "$3 is not a directory"
    exit 1
fi

#clone gitolite-admin into mod_dir
cd $3/$1
git clone git@192.168.210.103:gitolite-admin 
[[ $? -ne 0 ]] && exit 1

#Adding module into gitolite conf  
cd gitolite-admin
echo "repo $1" >> conf/gitolite.conf
echo -e "\tRW+ = git-admin" >> conf/gitolite.conf
echo "added module=$1" | xargs --null git commit -a -m 

git push
[[ $? -ne 0 ]] && rm -rf ../gitolite-admin && exit 1

#creating module structure inside mod_dir
/opt/pehu/bin/assoc-user.sh $1 $4 $2 $4
rm -rf $3/$1
