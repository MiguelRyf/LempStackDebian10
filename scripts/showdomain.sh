#!/bin/bash
# Script author: Miguel
# Show Domain
 
set -e

# Colours
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

# Check if you are root
if [ "$(whoami)" != 'root' ]; then
    echo "You have no permission to run $0 as non-root user. Use sudo"
    exit 1;
fi
 
clear
echo "Here all the domain on you server"
echo ""
echo "_____________"
echo "${blu}"
ls -I default -I phpmyadmin -I filemanager -1 /etc/nginx/sites-enabled/
echo "${end}_____________"
echo ""

rm -f /root/showdomain.sh
exit
