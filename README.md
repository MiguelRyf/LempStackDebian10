# Lemp Stack
LEMP (Linux eNginx Mysql PHP)

We will use mariadb as our database

Simple script developed during the coronavirus lockdown, this script will help to install LEMP (Linux eNginx Mysql PHP) with just a single command line.

## Fully Optimize
The installation will also optimize the configuration within LEMP.

## Installation List
Here all the list that the script will install
- Nginx: 1.14.2
- MariaDB: 10.3.22-MariaDB-0+deb10u1
- PHP 7: 7.3.14-1~deb10u1
- UFW Firewall
- Memcached
- FASTCGI_CACHE
- IONCUBE
- HTOP
- NETSTAT
- OPEN SSL
- AB BENCHMARKING TOOL
- ZIP AND UNZIP
- FFMPEG AND IMAGEMAGICK

## Prerequisites
What things you need to make sure before proceed.
* **ONLY FOR DEBIAN 10**
* **YOU SHOULD BE LOGIN AS ROOT**

## How to use
To Install this script, all you need to do is to run a single command line and it will install everything.

```
apt update; apt-get install dos2unix; wget https://raw.githubusercontent.com/MiguelRyf/LempStackDebian10/master/lemp-debian-10.sh -O ~/lemp-debian-10.sh && dos2unix ~/lemp-debian-10.sh && bash ~/lemp-debian-10.sh
```

## Getting Started
Congratulations, you now have installed LEMP!

Once everything is set up, run this command below in /root directory to open the Menu Options
```
./menu.sh
```
IF YOU ARE NOT IN /root DIRECTORY

JUST RUN THE COMMAND BELOW
```
cd
```

## Authors
* **Miguel Emmara** - *LempStackDebian10* - [MiguelRyf](https://github.com/MiguelRyf)
