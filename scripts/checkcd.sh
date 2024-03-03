#! /bin/bash


old=$(echo "$1" | sed 's/+.*//')
new=$(echo "$2" | sed 's/+.*//')
if [ "$old" != "$new" ]; then
    isCdRequired=true
else
    isCdRequired=false
fi
echo $isCdRequired
