#!/bin/bash

network_info=$(ifconfig)
ip_address=$(ip addr | grep 'inet ' | awk '{print $2}' | cut -d'/' -f1)
netmask=$(ip addr | grep 'inet ' | awk '{print $2}' | cut -d'/' -f2)
gateway=$(ip route | grep default | awk '{print $3}')

recipient="k213595@nu.edu.pk"
sender="k213607@nu.edu.pk"
subject="Network Information"
body="Network information of the system: \n\n $network_info\n\n $ip_address\n\n $netmask\n\n $gateway"


echo -e "$body" | mail -s "$subject" -a "From: $sender" "$recipient"
