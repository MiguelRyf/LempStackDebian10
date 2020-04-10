#!/bin/bash
# Script author: Miguel
# Install Rainloop
 
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
echo "                                   ${grn}INSTALL RAINLOOP${end}"
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

echo "Note* this will erase all of your data on your domain folder, then install rainloop webmail!"
echo "Feel free to backup any important files before hand!"
echo ""
echo "Here all the domain on you server"
echo ""
echo "_____________"
echo "${blu}"
ls -I default -I phpmyadmin -I filemanager -1 /etc/nginx/sites-enabled/
echo "${end}_____________"
echo ""
    read -p ${grn}"Please provide domain to be installed with rainloop${end}: " domain
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

# Add nginx Vhost.
configName=$domain
dollar='$'
request_uri="${dollar}request_uri"
uri="${dollar}uri"
args=${dollar}args
document_root="${dollar}document_root"
fastcgi_script_name="${dollar}fastcgi_script_name"
dollar1="${dollar}1"
dollar2="${dollar}2"
 
# Add nginx Vhost for domain
if ! echo "server {
   listen 80;
   root /var/www/$domain;
   index index.php index.html index.htm;
   error_log /var/log/nginx/$domain.error.log;
   server_name $domain www.$domain;
 
   location / {
       try_files $uri $uri/ /index.php?$args;
   }
 
   location ~* /(?:uploads|files)/.*\.(asp|bat|cgi|htm|html|ico|js|jsp|md|php|pl|py|sh|shtml|swf|twig|txt|yaml|yml|zip|gz|tar|bzip2|7z)$dollar { deny all; }
   location ~ \.php$dollar {
       fastcgi_split_path_info ^(.+\.php)(/.+)$dollar;
       fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
       fastcgi_index index.php;
       fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
       include fastcgi_params;
   }
 
   location = /favicon.ico {
       log_not_found off;
       access_log off;
   }

 	location ^~ /data {
  		deny all;
	}

   location = /robots.txt {
           try_files $uri $uri/ /index.php?$args;
       allow all;
       log_not_found off;
       access_log off;
   }
 
   location ~* \.(jpg|jpeg|png|gif|ico|css|js|eot|ttf|otf|woff|svg)$dollar {
       expires 365d;
   }
 
   location ~ /\.ht {
       deny all;
   }
 
   rewrite ^/sitemap_index\.xml$dollar /index.php?sitemap=1 last;
   rewrite ^/([^/]+?)-sitemap([0-9]+)?\.xml$dollar /index.php?sitemap=$dollar1&sitemap_n=$dollar2 last;
 
}
" > $sitesAvailable$configName
then
    echo "There is an ERROR create $configName file"
    exit;
else
    echo "New Virtual Host Created"
fi

# Intstall RianLoop
rm -rf /var/www/$domain/*
cd /var/www/$domain
wget http://www.rainloop.net/repository/webmail/rainloop-latest.zip
unzip rainloop-latest.zip
rm rainloop-latest.zip
systemctl restart nginx
chown -R www-data:www-data /var/www/$domain

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
 
    echo "${blu}Complete! $domain has been installed with RainLoop Webmail!"
    echo "Navigate to $domain/?admin in your browser to configure RainLoop"
	echo "The default login are:${end}"
	echo ""
    echo "${grn}Login: admin"
	echo "Password: 12345${end}"
    echo ""

rm -f /root/rainloop.sh
exit
