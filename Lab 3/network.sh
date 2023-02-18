#!/bin/bash

echo "IP addresses:"
ifconfig | grep "inet " | awk '{print $2}'

echo "Default gateway:"
route -n | grep "^0.0.0.0" | awk '{print $2}'

echo "DNS server:"
cat /etc/resolv.conf | grep "nameserver" | awk '{print $2}'
