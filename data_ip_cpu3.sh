#!/bin/bash

#while true; do
    date=$(date +%Y-%m-%d)
    ip=$(hostname -I)
    cpu_first_three=$(ps -eo user,cmd,%cpu --sort=-%cpu | head -4)
    echo -e "\nDate: $date \tIp: $ip \nTop 3 most CPU processes: \n$cpu_first_three\n"
    sleep 1
#done
