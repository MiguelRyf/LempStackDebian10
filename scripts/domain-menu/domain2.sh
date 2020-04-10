#!/bin/bash
# Script author: Miguel
# Add domain + Install Wordpress + Create Database

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
echo "                         ${grn}ADD DOMAIN + INSTALL WP + CREATE DATABASE${end}"
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
    read -p ${grn}"Please provide domain${end}: " domain
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
 
# Check if domain already added
if [ -e $sitesAvailable$domain ]; then
    echo "This domain already exists. Please delete your domain from the main menu options and try again"
    exit;
fi
 
# Check if domain already added var www
if [ -e /var/www/$domain ]; then
    echo "This domain already exists. Please delete your domain from the main menu options and try again"
    exit;
fi

### CREATE DATABASE ###
#nodot=${domain%%.*}
domainClear=${domain//./}
domainClear2=${domainClear//-/} 
echo "Type the password for your new $domain database [eg, password123_$domainClear2]"
echo -n "followed by [ENTER]: "
read PASS

mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE database_$domainClear2;
CREATE USER 'user_$domainClear2'@'localhost' IDENTIFIED BY '$PASS';
GRANT ALL PRIVILEGES ON database_$domainClear2.* TO 'user_$domainClear2'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT
 
# Add Domain to the server
mkdir /var/www/$domain
chown -R $USER:$USER /var/www/$domain
nginx -t
systemctl reload nginx

# Install ssl
mkdir -p /etc/ssl/$domain/
cd /etc/ssl/$domain/
openssl req -new -newkey rsa:2048 -sha256 -nodes -out $domain.csr -keyout $domain.key -subj "/C=US/ST=Rhode Island/L=East Greenwich/O=Fidelity Test/CN=$domain"
openssl x509 -req -days 36500 -in $domain.csr -signkey $domain.key -out $domain.crt
service nginx reload
 
# Install Wordpress
wget https://wordpress.org/latest.tar.gz
tar -xf latest.tar.gz
rm -f latest.tar.gz
mv wordpress $domain
mv $domain /var/www/
mv /var/www/$domain/wp-config-sample.php /var/www/$domain/wp-config.php
sed -i "s/database_name_here/database_$domainClear2/g" /var/www/$domain/wp-config.php
sed -i "s/username_here/user_$domainClear2/g" /var/www/$domain/wp-config.php
sed -i "s/password_here/$PASS/g" /var/www/$domain/wp-config.php
sed -i "s/( '/('/g" /var/www/$domain/wp-config.php
sed -i "s/' )/')/g" /var/www/$domain/wp-config.php
sed -i "s/table_prefix =/table_prefix  =/g" /var/www/$domain/wp-config.php

# Delete themes & plugin from wordpress
# rm -f /var/www/$domain/wp-content/themes/twentytwenty
rm -rf /var/www/$domain/wp-content/themes/twentynineteen
rm -rf /var/www/$domain/wp-content/themes/twentyseventeen
rm -rf /var/www/$domain/wp-content/themes/twentysixteen
rm -rf /var/www/$domain/wp-content/plugins/akismet
rm -rf /var/www/$domain/wp-content/plugins/hello.php

# Install plugin
cd /var/www/$domain/wp-content/plugins
wget https://downloads.wordpress.org/plugin/all-in-one-wp-migration.zip
unzip all-in-one-wp-migration.zip
rm -rf all-in-one-wp-migration.zip
wget https://downloads.wordpress.org/plugin/classic-editor.zip
unzip classic-editor.zip
rm -rf classic-editor.zip
wget https://downloads.wordpress.org/plugin/really-simple-ssl.zip
unzip really-simple-ssl.zip
rm -rf really-simple-ssl.zip
wget https://downloads.wordpress.org/plugin/all-in-one-seo-pack.zip
unzip all-in-one-seo-pack.zip
rm -rf all-in-one-seo-pack.zip

# Install Nginx Cache
phpToChange="<?php echo esc_attr( get_option( 'nginx_cache_path' ) ); ?>"
wget https://downloads.wordpress.org/plugin/nginx-cache.zip
unzip nginx-cache.zip
rm -rf nginx-cache.zip
sed -i "s/<?php echo esc_attr( get_option( 'nginx_cache_path' ) ); ?>/\/etc\/nginx\/mycache\/$domain/g" /var/www/$domain/wp-content/plugins/nginx-cache/includes/settings-page.php
cd

chown -R www-data:www-data /var/www/$domain
systemctl restart php7.3-fpm.service
systemctl restart nginx
 
# Add Cache to the server
mkdir -p /etc/nginx/mycache/$domain
 
# Add nginx Vhost for domain
configName=$domain
cd $sitesAvailable
wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/vhost-fastcgi -O $domain
sed -i "s/domain.com/$domain/g" $sitesAvailable$configName
 
# PHP POOL SETTING
php7_dotdeb="https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/php7dotdeb"
wget -q $php7_dotdeb -O /etc/php/7.3/fpm/pool.d/$domain.conf
sed -i "s/domain.com/$domain/g" /etc/php/7.3/fpm/pool.d/$domain.conf
echo "" >> /etc/php/7.3/fpm/pool.d/$domain.conf
dos2unix /etc/php/7.3/fpm/pool.d/$domain.conf > /dev/null 2>&1
service php7.3-fpm reload
 
ln -s $sitesAvailable$configName $sitesEnable$configName
nginx -t
systemctl reload nginx
 
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

    echo "Complete! Your new $domain domain has been added! Below is your database credentials..."
	echo "PLEASE SAVE BELOW INFORMATION."
	echo "Database:   database_$domainClear2"
	echo "Username:   user_$domainClear2"
	echo "Password:   $PASS"
	echo ""
 
rm -f /root/adddomaininstallwordpresscreatedbv3.sh
exit
