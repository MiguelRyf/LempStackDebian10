#!/bin/bash
# Script author: Miguel
# Main Menu of the scripts
 
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
  
      3) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/main-menu/showdomain.sh -O ~/showdomain.sh && dos2unix ~/showdomain.sh && bash ~/showdomain.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

      4) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/database-menu/show-databases.sh -O ~/show-databases.sh && dos2unix ~/show-databases.sh && bash ~/show-databases.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

      5) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/addons/rainloop.sh -O ~/rainloop.sh && dos2unix ~/rainloop.sh && bash ~/rainloop.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

      6) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/addons/filerun.sh -O ~/filerun.sh && dos2unix ~/filerun.sh && bash ~/filerun.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

   7) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/main-menu/changeportsshd.sh -O ~/changeportssh.sh && dos2unix ~/changeportssh.sh && bash ~/changeportssh.sh;
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

   10) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/main-menu/restartserver.sh -O ~/restartserver.sh && dos2unix ~/restartserver.sh && bash ~/restartserver.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          main_menu;
          ;;

     11)  clear;
            echo "Bye!";
            echo "You can open the Main Menu by typing ${grn}./menu.sh${end}";
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

      1) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/domain-menu/domain1.sh -O ~/domain1.sh && dos2unix ~/domain1.sh && bash ~/domain1.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
      sub_menu1;
            ;;

      2) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/domain-menu/domain2.sh -O ~/domain2.sh && dos2unix ~/domain2.sh && bash ~/domain2.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
      sub_menu1;
            ;;

      3) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/domain-menu/domain3.sh -O ~/domain3.sh && dos2unix ~/domain3.sh && bash ~/domain3.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          sub_menu1;
          ;;

      4) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/domain-menu/domain4.sh -O ~/domain4.sh && dos2unix ~/domain4.sh && bash ~/domain4.sh;
      read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          sub_menu1;
          ;;

      5) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/main-menu/showdomain.sh -O ~/showdomain.sh && dos2unix ~/showdomain.sh && bash ~/showdomain.sh;
      read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          sub_menu1;
          ;;

      6) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/domain-menu/delete.sh -O ~/delete.sh && dos2unix ~/delete.sh && bash ~/delete.sh;
      read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          sub_menu1;
          ;;

   7) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/domain-menu/backupwebdata.sh -O ~/backupwebdata.sh && dos2unix ~/backupwebdata.sh && bash ~/backupwebdata.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          sub_menu1;
          ;;

     8)   clear;
            main_menu;
            ;;

     9)   clear;
            echo "Bye!";
            echo "You can open the Main Menu by typing ${grn}./menu.sh${end}";
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

    1) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/database-menu/create-database.sh -O ~/create-database.sh && dos2unix ~/create-database.sh && bash ~/create-database.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          sub_menu2;
          ;;

    2) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/database-menu/delete-database.sh -O ~/delete-database.sh && dos2unix ~/delete-database.sh  && bash ~/delete-database.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          sub_menu2;
          ;;

      3) wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/scripts/database-menu/show-databases.sh -O ~/show-databases.sh && dos2unix ~/show-databases.sh && bash ~/show-databases.sh;
            read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey;
          sub_menu2;
          ;;
          
     4)   clear;
            main_menu;
            ;;

     5)   clear;
            echo "Bye!";
            echo "You can open the Main Menu by typing ${grn}./menu.sh${end}";
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
