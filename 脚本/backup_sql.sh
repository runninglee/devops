#!/bin/bash
# Author: <lihui870920@gmail.com>
# Date  : 2016-09-23 11:20
# Backup current user's database

#Database Name
database="dbname"

#Username
username="username"

#Password
password="password"


echo "You are going to backup the $database on this disk"


#
so=".sql"


#FileName
filename="$database-"`date +%Y-%m-%d-%H-%M`"$so"


#Path
path="$(pwd)/$filename"

#CMD
cmd="mysqldump -u$username -p$password $database >$path"

#Run CMD

if [ -f "$path" ]
then
    echo "The package has been here."
else
    #CMD
    `$cmd`
    echo "Great, $filename has been created!"
fi