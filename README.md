# Nmap-and-testssl-script

The Script for Nmap and SSL scanning


Summary

I have created this script to reduce repetitive work while performing scanning of target host.
This script will automate the process of Recon which need to be done everytime you need to scan host.
This script will help you to find open ports,running service and verion along with it testssl bash script is also been used to perform ssl scan on the host.


Requirements:

To run this script, Nmap and Testssl need to be there in your system.

Install Nmap:

On CentOS
yum install nmap

On Debian
apt-get install nmap

On Ubuntu
sudo apt-get install nmap

Installing  TestSSL:

You can download testssl.sh branch 3.1dev just by cloning this git repository:
git clone --depth 1 https://github.com/drwetter/testssl.sh.git


Examples of use:

./nmaptester.sh

Note: run the script as root user
