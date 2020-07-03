#!/bin/bash
# Script author: Miguel
# Install Filerun
 
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
domain2=$2
sitesEnable='/etc/nginx/sites-enabled/'
sitesAvailable='/etc/nginx/sites-available/'
domainRegex="^[a-zA-Z0-9]"

# Ask the user to add domain name
while true
do
clear
clear
echo "########################### SERVER CONFIGURED BY MIGUEL EMMARA ###########################"
echo "                                   ${grn}INSTALL FILERUN${end}"
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

echo "Note* this will erase all of your data on your domain folder, then install Filerun!"
echo "Preferably install Filerun on your subdomain [eg, manage.domain.com]"
echo "Feel free to backup any important files before hand!"
echo ""
echo "Here all the domain on you server"
echo ""
echo "_____________"
echo "${blu}"
ls -I default -I phpmyadmin -I filemanager -1 /etc/nginx/sites-enabled/
echo "${end}_____________"
echo ""
    read -p ${grn}"Please provide domain [eg, manage.domain.com]${end}: " domain
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

# Install Filerun
rm -rf /var/www/$domain/*
cd /var/www/$domain/
wget -O FileRun.zip http://www.filerun.com/download-latest
unzip FileRun.zip
chown -R www-data:www-data /var/www/$domain/
chown -R root:root /var/www/$domain
chown -R www-data:www-data /var/www/$domain/system/data
chown www-data:www-data /var/www/

# Change vhost to no fastcgi cache.
configName=$domain
cd $sitesAvailable
wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/vhost-nocache -O $domain
sed -i "s/domain.com/$domain/g" $sitesAvailable$configName

# Create Database For Filerun
domainClear=${domain//./} # Domain name variable
domainClear2=${domainClear//-/} # Domain name variable 
password_filerun=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1` # Generate random password and save it to password_filerun variable.
mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE filerun_db_$domainClear2;
CREATE USER 'filerun_usr_$domainClear2'@'localhost' IDENTIFIED BY '$password_filerun';
GRANT ALL PRIVILEGES ON filerun_db_$domainClear2.* TO 'filerun_usr_$domainClear2'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Restart nginx and php-fpm
echo "Restart Nginx & PHP-FPM ..."
echo ""
sleep 1
systemctl restart nginx
systemctl restart php7.3-fpm.service
clear
 
# Success Prompt
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
 
    echo "Complete! $domain has been installed with Filerun!"
    echo "Navigate to ${grn}$domain${end} in your browser to configure Filerun"
	echo ""
	echo "Database Name: filerun"
	echo "User Name: filerun"
	echo "Password: $password_filerun"
	echo ""
 
rm -f /root/filerun.sh
exit
