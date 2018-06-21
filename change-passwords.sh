#!/bin/bash


hashbegin="123@"
hashend="!456"

mysql -u root -psneppass -D snep -e "select id,name from peers;" > peers.txt;
cat peers.txt | sed "1d" > peers2.txt;

rm -r peers.txt

while read -r line; do
        id=$(echo $line | awk '{ print $1}')
        user=$(echo $line | awk '{ print $2}')
        mysql -u root -psneppass -D snep -e "UPDATE peers SET secret='$hashbegin$user@hashend' where id=$id;"



done < "peers2.txt"

rm -r peers2.txt
