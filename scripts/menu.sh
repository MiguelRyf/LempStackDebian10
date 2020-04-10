#!/bin/bash
# Script author: Miguel
# Menu V: 3.0
 
set -e
 
# Colours
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

main_menu(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`

clear
# display menu
echo "Server Name - ${grn}$(hostname)${end}"
echo "-------------------------------------------------------------------------"
echo "M A I N - M E N U"
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
echo "-------------------------------------------------------------------------"
echo "Choose Your Options"
echo ""
echo "  ${grn}1) DOMAIN MENU >"
echo "  2) DATABASE MENU >"
echo "  3) SHOW CURRENT DOMAIN"
echo "  4) SHOW CURRENT DATABASE"
echo "  5) INSTALL RAINLOOP WEBMAIL"
echo "  6) INSTRALL FILERUN"
echo "  7) CHANGE PORT SSH"
echo "  8) REFRESH SERVER"
echo "  9) CLEAR CACHE RAM"
echo "  10) ${red}RESTART SERVER${end}"
echo "  ${grn}11) EXIT MENU${end}"
echo ""
read -p "Choose your option [1-11]: " choice

  while [ choice != '' ]
  do
    if [[ $choice = "" ]]; then
      exit;
    else
      case $choice in
      1) clear;
      # option_picked "Sub Menu 1";
      sub_menu1;
      ;;

      2) clear;
      # option_picked "Sub Menu 2";
      sub_menu2;
      ;;
  
      3) wget https://pastebin.com/raw/VQ4ax66A -O ~/showdomain.sh && dos2unix ~/showdomain.sh && bash ~/showdomain.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

      4) wget https://pastebin.com/raw/cB7vTv0p -O ~/showdatabases.sh && dos2unix ~/showdatabases.sh && bash ~/showdatabases.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

      5) wget https://pastebin.com/raw/j9e6whVt -O ~/rainloop.sh && dos2unix ~/rainloop.sh && bash ~/rainloop.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

      6) wget https://pastebin.com/raw/eFFdF55U -O ~/filerun.sh && dos2unix ~/filerun.sh && bash ~/filerun.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

   7) wget https://pastebin.com/raw/x9cxTiT4 -O ~/changeportssh.sh && dos2unix ~/changeportssh.sh && bash ~/changeportssh.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

   8)     clear;
            systemctl restart php7.3-fpm.service;
            systemctl restart nginx;
            echo "${cyn}Server Refreshed!${end}";
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;  

   9)   clear;
            echo 3 > /proc/sys/vm/drop_caches;
            echo "${cyn}RAM CACHE CLEARED!${end}";
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

   10) wget https://pastebin.com/raw/5zJ0HqPb -O ~/restartserver.sh && dos2unix ~/restartserver.sh && bash ~/restartserver.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

     11)  clear;
            echo "Bye!";
            echo "You can open the Main Menu by typing ${grn}./menuv3.sh${end}";
            exit;
            ;;

        *)
            echo "Error: Invalid option..."
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
      main_menu;
            ;;
      esac
    fi
  done
}

function option_picked() {
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE=${@:-"${RESET}Error: No message passed"}
    echo -e "${COLOR}${MESSAGE}${RESET}"
}

sub_menu1(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`

clear
echo "Server Name - ${grn}$(hostname)${end}"
echo "-------------------------------------------------------------------------"
echo "D O M A I N - M E N U"
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
echo "-------------------------------------------------------------------------"
echo "Choose Your Options"
echo ""
echo "  ${grn}1) ADD DOMAIN"
echo "  2) ADD DOMAIN + INSTALL WORDPRESS"
echo "  3) ADD SUB-DOMAIN"
echo "  4) ADD SUB-DOMAIN + INSTALL WORDPRESS"
echo "  5) SHOW CURRENT DOMAIN"
echo "  6) DELETE DOMAIN / SUB-DOMAIN"
echo "  7) BACKUP WEB"
echo "  8) BACK TO MAIN MENU <"
echo "  9) EXIT MENU${end}"
echo ""
read -p "Choose your option [1-9]: " submenudomain

  while [ submenudomain != '' ]
  do
    if [[ $submenudomain = "" ]]; then
      exit;
    else
      case $submenudomain in

      1) wget https://pastebin.com/raw/QjsHUZSt -O ~/adddomainonlyv3.sh && dos2unix ~/adddomainonlyv3.sh && bash ~/adddomainonlyv3.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
      sub_menu1;
            ;;

      2) wget https://pastebin.com/raw/zjV3JPeR -O ~/adddomaininstallwordpresscreatedbv3.sh && dos2unix ~/adddomaininstallwordpresscreatedbv3.sh && bash ~/adddomaininstallwordpresscreatedbv3.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
      sub_menu1;
            ;;

      3) wget https://pastebin.com/raw/STPQu4m2 -O ~/addsubdomainonlyv3.sh && dos2unix ~/addsubdomainonlyv3.sh && bash ~/addsubdomainonlyv3.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          sub_menu1;
          ;;

      4) wget https://pastebin.com/raw/adyh06NL -O ~/addsubdomaininstallwordpresscreatedbv3.sh && dos2unix ~/addsubdomaininstallwordpresscreatedbv3.sh && bash ~/addsubdomaininstallwordpresscreatedbv3.sh;
      read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          sub_menu1;
          ;;

      5) wget https://pastebin.com/raw/VQ4ax66A -O ~/showdomain.sh && dos2unix ~/showdomain.sh && bash ~/showdomain.sh;
      read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          sub_menu1;
          ;;

      6) wget https://pastebin.com/raw/SM4cSqbw -O ~/deleteeverythingv3.sh && dos2unix ~/deleteeverythingv3.sh && bash ~/deleteeverythingv3.sh;
      read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          sub_menu1;
          ;;

   7) wget https://pastebin.com/raw/CjJH1jdh -O ~/backupweb.sh && dos2unix ~/backupweb.sh && bash ~/backupweb.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          sub_menu1;
          ;;

     8)   clear;
            main_menu;
            ;;

     9)   clear;
            echo "Bye!";
            echo "You can open the Main Menu by typing ${grn}./menuv3.sh${end}";
            exit;
            ;;

        *)
            echo "Error: Invalid option..."
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
      sub_menu1;
            ;;
      esac
    fi
  done
}

sub_menu2(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`

clear
echo "Server Name - ${grn}$(hostname)${end}"
echo "-------------------------------------------------------------------------"
echo "D A T A B A S E - M E N U"
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
echo "-------------------------------------------------------------------------"
echo "Choose Your Options"
echo ""
echo "  ${grn}1) CREATE DATABASE"
echo "  2) DELETE DATABASE"
echo "  3) SHOW CURRENT DATABASE"
echo "  4) BACK TO MAIN MENU <"
echo "  5) EXIT MENU${end}"
echo ""
read -p "Choose your option [1-5]: " submenudomain2

  while [ submenudomain2 != '' ]
  do
    if [[ $submenudomain2 = "" ]]; then
      exit;
    else
      case $submenudomain2 in

    1) wget https://pastebin.com/raw/wUGQGrCJ -O ~/createdatabase.sh && dos2unix ~/createdatabase.sh && bash ~/createdatabase.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          sub_menu2;
          ;;

    2) wget https://pastebin.com/raw/Us1Zs2un -O ~/deletedatabase.sh && dos2unix ~/deletedatabase.sh  && bash ~/deletedatabase.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          sub_menu2;
          ;;

      3) wget https://pastebin.com/raw/cB7vTv0p -O ~/showdatabases.sh && dos2unix ~/showdatabases.sh && bash ~/showdatabases.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          sub_menu2;
          ;;
          
     4)   clear;
            main_menu;
            ;;

     5)   clear;
            echo "Bye!";
            echo "You can open the Main Menu by typing ${grn}./menuv3.sh${end}";
            exit;
            ;; 

        *)
            echo "Error: Invalid option..."
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
      sub_menu2;
            ;;
      esac
    fi
  done
}

clear
main_menu