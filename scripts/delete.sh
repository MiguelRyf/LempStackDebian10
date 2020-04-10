#!/bin/bash
# Script author: Miguel
# Delete Everything
 
set -e
 
# Colours
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'
 
# Variables.
domain=$1
db=$2
domain2=$3
userdb1=$4
userdb2=$5
sitesEnable='/etc/nginx/sites-enabled/'
sitesAvailable='/etc/nginx/sites-available/'
domainRegex="^[a-zA-Z0-9]"
 
# Check if you are root
if [ "$(whoami)" != 'root' ]; then
    echo "You have no permission to run $0 as non-root user. Use sudo"
    exit 1;
fi
 
# Ask the user to add domain name
while true
do
clear
echo "########################### SERVER CONFIGURED BY MIGUEL EMMARA ###########################"
echo "                        ${grn}DELETE DOMAIN + DELETE DATABASE + DELETE SSL${end}"
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
echo "Here all the domain on you server"
echo ""
echo "_____________"
echo "${blu}"
ls -I default -I phpmyadmin -I filemanager -1 /etc/nginx/sites-enabled/
echo "${end}_____________"
 
    echo ""
    echo "${yel}Please note, all data on your domain will be gone, proceed will caution!${end}"
    echo ""
    read -p ${grn}"Please provide domain to be deleted: ${end}: " domain
    read -p ${grn}"Please type your domain one more time${end}: " domain2
    echo
    [ "$domain" = "$domain2" ] && break
    echo "Domain you provide does not match, please try again!"
    read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
done
 
until [[ $domain =~ $domainRegex ]]
do
    echo -n "Enter valid domain: "
    read domain
done
 
# Check if domain is not there
FILE=/etc/nginx/sites-available/$domain
file2=/var/www/$domain
if [ -f "$FILE" ] || [ -f "$file2" ] ; then
    clear
else
    echo ""
    echo "$domain does not exist, please try again"
    exit;
fi
 
clear

# Delete Database
domainClear=${domain//./}
domainClear2=${domainClear//-/}
mariadb <<MYSQL_SCRIPT
DROP DATABASE database_$domainClear2;
DROP USER 'user_$domainClear2'@'localhost';
MYSQL_SCRIPT
clear
 
# Delete domain.
rm -fr /var/www/$domain
unlink /etc/nginx/sites-enabled/$domain
rm -f /etc/nginx/sites-available/$domain
rm -f /var/log/nginx/$domain.error.log
rm -f /etc/php/7.3/fpm/pool.d/$domain.conf

# Delete ssl.
rm -rf /etc/letsencrypt/live/$domain /etc/letsencrypt/renewal/$domain.conf /etc/letsencrypt/archive/$domain
rm -rf /etc/ssl/$domain
service nginx reload

# Delete Cache.
rm -rf /etc/nginx/mycache/$domain

    systemctl reload nginx
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
echo "Domain $domain has been successfuly deleted along with database and SSL!"
rm -f /root/deleteeverythingv3.sh
exit
