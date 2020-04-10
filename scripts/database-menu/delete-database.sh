#!/bin/bash
# Script author: Miguel
# Delete Database

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

# Variables
domain=$1
userdb1=$2
userdb2=$3
sitesEnable='/etc/nginx/sites-enabled/'
sitesAvailable='/etc/nginx/sites-available/'
domainRegex="^[a-zA-Z0-9]"

# Delete Database
while true
do
clear
echo "########################### SERVER CONFIGURED BY MIGUEL EMMARA ###########################"
echo "                                   ${grn}DELETE DATABASE${end}"
echo " __  __ _                  _   ______"                                    
echo "|  \/  (_)                | | |  ____|                                    "
echo "| \  / |_  __ _ _   _  ___| | | |__   _ __ ___  _ __ ___   __ _ _ __ __ _ "
echo "| |\/| | |/ _  | | | |/ _ \ | |  __| | '_   _ \| '_   _ \ / _  | '__/ _  |"
echo "| |  | | | (_| | |_| |  __/ | | |____| | | | | | | | | | | (_| | | | (_| |"
echo "|_|  |_|_|\__, |\__,_|\___|_| |______|_| |_| |_|_| |_| |_|\__,_|_|  \__,_|"
echo "           __/ |"                                                        
echo "          |___/"
echo ""
echo "${grn}Press [CTRL + C] to cancel...${end}"
echo ""
echo "YOUR DATABASES"
echo "___________"
echo "${grn}"
mariadb <<MYSQL_SCRIPT
SHOW DATABASES;
MYSQL_SCRIPT
echo "${end}___________"
echo ""
read -p ${grn}"Type your database name you want to delete${end}: " userdb1
read -p ${grn}"Type your database name one more time${end}: " userdb2
echo
[ "$userdb1" = "$userdb2" ] && break
echo "Database name you provide does not match, please try again!"
read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
done

#check if database is not exist
DATABASE=/var/lib/mysql/$userdb1
if [ -e $DATABASE ]; then
    echo ""
else
    echo ""
    echo "$userdb1 does not exist in the database, please try again"
    exit;
fi

clear
echo "YOUR DATABASE USER"
echo "___________"
echo "${grn}"
mariadb <<MYSQL_SCRIPT
SELECT User FROM mysql.user;
MYSQL_SCRIPT
echo "${end}___________"
echo ""
echo -n "Type your user database name you want to delete [eg, user_domain]: "
read usr

mariadb <<MYSQL_SCRIPT
DROP DATABASE $userdb1;
DROP USER '$usr'@'localhost';
MYSQL_SCRIPT

clear
echo "Script By"
echo ""
echo " __  __ _                  _   ______"                                    
echo "|  \/  (_)                | | |  ____|                                    "
echo "| \  / |_  __ _ _   _  ___| | | |__   _ __ ___  _ __ ___   __ _ _ __ __ _ "
echo "| |\/| | |/ _  | | | |/ _ \ | |  __| | '_   _ \| '_   _ \ / _  | '__/ _  |"
echo "| |  | | | (_| | |_| |  __/ | | |____| | | | | | | | | | | (_| | | | (_| |"
echo "|_|  |_|_|\__, |\__,_|\___|_| |______|_| |_| |_|_| |_| |_|\__,_|_|  \__,_|"
echo "           __/ |"                                                        
echo "          |___/"
echo ""
service nginx reload
echo "Your database $userdb1 has been successfuly deleted!"
rm -f /root/delete-database.sh
exit
