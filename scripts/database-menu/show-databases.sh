#!/bin/bash
# Script author: Miguel
# Show Databases
 
set -e

# Colours
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

clear
echo "Here all the databases on your server "
echo "___________"
echo "${blu}"
mariadb <<MYSQL_SCRIPT
show databases;
MYSQL_SCRIPT
echo "${end}___________"
echo ""

rm -f /root/show-databases.sh
exit
