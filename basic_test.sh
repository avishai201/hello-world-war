#!/bin/bash

myip="$(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')"
echo $myip

if curl -I "http://${myip}:8081" 2>&1 | grep -w "200\|301" ; then
    echo "server is up"
else
    echo "server is down"
    exit 1
fi

exit 0