#!/bin/bash
ls
while true; do
    sleep 1
    ps -C $1 | grep "sleep" 
    if [ $? -ne 0 ]; then 
        echo "$?"
        break
    fi
done
