#!/bin/bash
# Author : Himanshu Dhote 

echo " 
=========================================
=      The Nmap & testssl Scanner       =
=                                       =
=                   -by Himanshu Dhote  =
========================================= "

read -p 'Enter target IP address: ' target
#read target
$nmapType nmap -sC -sV -vv --script ssh2-enum-algos -oA Basic_"$target".nmap "$target" 
bash /home/kali/Downloads/testssl.sh-3.1dev/testssl.sh --warnings=batch --html "$target"
