#!/bin/bash
echo "set vars"
sed -i '$ a \\nexport USERLAMER=\"lamer\"'  /etc/profile
sed -i '$ a export WWWFOLDER=\"public_html\"'  /etc/profile
sed -i '$ a export MYFOLDER=\"\/my\"'  /etc/profile
sed -i '$ a export BACKUPFOLDER=\"\/var\/backups\"'  /etc/profile
sed -i '$ a export BACKUPFOLDER_EMPTY=\"$BACKUPFOLDER\/vds\/empty\"'  /etc/profile
sed -i '$ a export BACKUPFOLDER_DAYS=\"$BACKUPFOLDER\/vds\/days\"'  /etc/profile
sed -i '$ a export BACKUPFOLDER_IMPORTANT=\"$BACKUPFOLDER\/vds\/important\"'  /etc/profile
sed -i '$ a export HOMEPATHSYSUSERS=\"\/home\/system\"'  /etc/profile
sed -i '$ a export HOMEPATHWEBUSERS=\"\/home\/webusers\"'  /etc/profile
sed -i '$ a export NGINXAVAILABLE=\"\/etc\/nginx\/sites-available\"'  /etc/profile
sed -i '$ a export NGINXENABLED="\/etc\/nginx\/sites-enabled\"'  /etc/profile
sed -i '$ a export APACHEAVAILABLE=\"\/etc\/apache2\/sites-available\"'  /etc/profile
sed -i '$ a export APACHEENABLED="\/etc\/apache2\/sites-enabled\"'  /etc/profile
sed -i '$ a export HTTPNGINXPORT=80'  /etc/profile
sed -i '$ a export HTTPSNGINXPORT=443'  /etc/profile
sed -i '$ a export HTTPAPACHEPORT=8080'  /etc/profile
sed -i '$ a export HTTPSAPACHEPORT=8081'  /etc/profile
sed -i '$ a PATH=$PATH:\/my\/scripts\/system/'  /etc/profile
sed -i '$ a PATH=$PATH:\/my\/scripts\/users/'  /etc/profile
sed -i '$ a PATH=$PATH:\/my\/scripts\/webserver/'  /etc/profile
sed -i '$ a PATH=$PATH:\/my\/scripts/'  /etc/profile
source /etc/profile
sed -i '$ a export SCRIPTS=\'$MYFOLDER'\/scripts'  /etc/profile
sed -i '$ a export MENU=\'$MYFOLDER'\/scripts\/.menu'  /etc/profile
sed -i '$ a PATH=$PATH:'$HOMEPATHSYSUSERS\/$USERLAMER'\/.composer\/vendor\/bin'  /etc/profile
sed -i '$ a export TEMPLATES="\/my'$MYFOlDER'\/scripts\/.config\/templates"'  /etc/profile
sed -i '$ a export SETTINGS="\/my'$MYFOlDER'\/scripts\/.config\/settings"'  /etc/profile
source /etc/profile
sed -i "$ a export COLOR_NC='\\\e[0m'"  /etc/profile
sed -i "$ a export COLOR_WHITE='\\\e[1;37m'"  /etc/profile
sed -i "$ a export COLOR_BLACK='\\\e[0;30m'"  /etc/profile
sed -i "$ a export COLOR_BLUE='\\\e[1;34m'"  /etc/profile
sed -i "$ a export COLOR_LIGHT_BLUE='\\\e[0;32m'"  /etc/profile
sed -i "$ a export COLOR_LIGHT_GREEN='\\\e[0;36m'"  /etc/profile
sed -i "$ a export COLOR_LIGHT_CYAN='\\\e[1;36m'"  /etc/profile
sed -i "$ a export COLOR_RED='\\\e[0;31m'"  /etc/profile
sed -i "$ a export COLOR_LIGHT_RED='\\\e[1;31m'"  /etc/profile
sed -i "$ a export COLOR_PURPLE='\\\e[0;35m'"  /etc/profile
sed -i "$ a export COLOR_LIGHT_PURPLE='\\\e[1;35m'"  /etc/profile
sed -i "$ a export COLOR_BROWN='\\\e[0;33m'"  /etc/profile
sed -i "$ a export COLOR_YELLOW='\\\e[1;33m'"  /etc/profile
sed -i "$ a export COLOR_GRAY='\\\e[0;30m'"  /etc/profile
sed -i "$ a export COLOR_LIGHT_GRAY='\\\e[0;37m'"  /etc/profile
sed -i "$ a export COLOR_GREEN='\\\e[0;32m'"  /etc/profile
source /etc/profile

echo "make dirs"
mkdir -p $BACKUPFOLDER_EMPTY
mkdir -p $BACKUPFOLDER_DAYS
mkdir -p $BACKUPFOLDER_IMPORTANT
mkdir -p $BACKUPFOLDER_IMPORTANT/ssh
mkdir -p $MYFOLDER
mkdir -p $HOMEPATHSYSUSERS
mkdir -p $HOMEPATHWEBUSERS
mkdir -p $TEMPLATES
mkdir -p $SETTINGS
mkdir /etc/skel/logs
mkdir /etc/skel/tmp
mkdir /etc/skel/$WWWFOLDER

echo "make backups"
cp -R /etc/ $BACKUPFOLDER_EMPTY/
mv $BACKUPFOLDER_EMPTY/etc $BACKUPFOLDER_EMPTY/_etc
cp -R /etc/default/ $BACKUPFOLDER_EMPTY/
cp -R /etc/bind/ $BACKUPFOLDER_EMPTY/
cp -R /etc/cron.d/ $BACKUPFOLDER_EMPTY/
cp -R /etc/cron.daily/ $BACKUPFOLDER_EMPTY/
cp -R /etc/cron.hourly/ $BACKUPFOLDER_EMPTY/
cp -R /etc/cron.monthly/ $BACKUPFOLDER_EMPTY/
cp -R /etc/cron.weekly/ $BACKUPFOLDER_EMPTY/
cp -R /etc/network/ $BACKUPFOLDER_EMPTY/
cp -R /etc/pam.d/ $BACKUPFOLDER_EMPTY/
cp -R /etc/skel/ $BACKUPFOLDER_EMPTY/
cp -R /etc/ssl/ $BACKUPFOLDER_EMPTY/
cp /etc/hosts $BACKUPFOLDER_EMPTY/hosts
cp /etc/bash.bashrc $BACKUPFOLDER_EMPTY/bash.bashrc
cp /etc/profile $BACKUPFOLDER_EMPTY/profile
cp /etc/sudoers $BACKUPFOLDER_EMPTY/sudoers

echo "set locale"
sudo locale-gen "ru_RU.UTF-8"
dpkg-reconfigure locales

echo "set default"
sed -i -e "s/LANG=en_US.UTF-8/LANG=ru_RU.UTF-8/" /etc/default/locale
sed -i -e "s/# GROUP=100/GROUP=100/" /etc/default/useradd
###вернуться к этому позже
#sed -i -e 's/'# HOME=\/home'/'HOME=$HOMEPATHSYSUSERS'/' /etc/default/useradd
#sed -i -e 's/"# HOME=\/home"/"HOME=$HOMEPATHSYSUSERS"/' /etc/default/useradd
#sed -i 's|'# HOME=\/home'|HOME=$HOMEPATHSYSUSERS|g' /etc/default/useradd

#echo "ssh settings"
cp -R /etc/ssh/ $BACKUPFOLDER_EMPTY/
sed -i -e "s/#Port 22/Port 6666/" /etc/ssh/sshd_config
sed -i -e "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
#sed -i -e "s/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/" /etc/ssh/sshd_config

#sed -i '$ a \\nAuthenticationMethods publickey,password publickey,keyboard-interactive'  /etc/ssh/sshd_config
#sed -i -e "s/@include common-auth/#@include common-auth/" /etc/pam.d/sshd
#service sshd restart

echo "install webmin"
apt update
apt install software-properties-common apt-transport-https wget
wget -q http://www.webmin.com/jcameron-key.asc -O- | sudo apt-key add -
add-apt-repository "deb [arch=amd64] http://download.webmin.com/download/repository sarge contrib"
apt install webmin
cp -R /etc/webmin/ $BACKUPFOLDER_EMPTY/

echo "install soft"
apt install mc git git-core composer  wget zip unzip unrar arj putty-tools nano  ufw proftpd  apache2
apt install curl build-essential software-properties-common
echo "php repository"
add-apt-repository ppa:ondrej/php
add-apt-repository ppa:nilarimogard/webupd8
echo "letsencrypt"
apt update
apt -y upgrade
apt install launchpad-getkeys
apt install letsencrypt
launchpad-getkeys

echo "make backups"
cp -R /etc/mc/ $BACKUPFOLDER_EMPTY/
cp -R /etc/ufw $BACKUPFOLDER_EMPTY/
cp -R /etc/proftpd/ $BACKUPFOLDER_EMPTY/

echo "php"
apt -y install php-pear php5.6-curl php5.6-dev php5.6-gd php5.6-mbstring php5.6-zip php5.6-mysql php5.6-xml
apt -y install php-pear php7.0-zip php7.0-curl php7.0-gd php7.0-mysql php7.0-mcrypt php7.0-xml libapache2-mod-php7.0
apt -y install php-pear php7.1-curl php7.1-dev php7.1-gd php7.1-mbstring php7.1-zip php7.1-mysql php7.1-xml
apt -y install php-pear php7.2-curl php7.2-dev php7.2-gd php7.2-mbstring php7.2-zip php7.2-mysql php7.2-xml
apt -y install php-pear php7.3-curl php7.3-dev php7.3-gd php7.3-mbstring php7.3-zip php7.3-mysql php7.3-xml
update-alternatives --set php /usr/bin/php7.2

echo "install mcrypt"
apt install php-dev libmcrypt-dev php-pear
apt-get install php7.0-mcrypt
apt-get install php7.1-mcrypt
apt-get install php7.2-mcrypt
apt-get install php7.3-mcrypt
apt-get install php5.6-mcrypt
#pecl install mcrypt-1.0.1
#echo "extension=mcrypt.so" | sudo tee -a /etc/php/7.2/apache2/conf.d/mcrypt.ini

apt -y install nginx php libapache2-mod-php php-zip php7.2-zip php7.3-zip php7.1-zip php7.0-zip apache2 php-fpm php-gd php-mysql

echo "make backups"
cp -R /etc/apache2/ $BACKUPFOLDER_EMPTY/
cp -R /etc/nginx/ $BACKUPFOLDER_EMPTY/
cp -R /etc/php/ $BACKUPFOLDER_EMPTY/

echo "nginx settings"
#sed -i -e "s/# server_names_hash_bucket_size 64;/server_names_hash_bucket_size 64;/" /etc/nginx/nginx.conf
cp -R $MYFOLDER/scripts/.config/settings/nginx/nginx.conf /etc/nginx/nginx.conf
cp -R $MYFOLDER/scripts/.config/settings/nginx/nginxconfig.io/ /etc/nginx/
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default


echo "apache conf"
/etc/init.d/apache2 stop
sed -i -e "s/Listen 80/Listen 8080/" /etc/apache2/ports.conf
sed -i -e "s/Listen 443/Listen 8443/" /etc/apache2/ports.conf
sed -i -e "s/Listen 443/Listen 8443/" /etc/php/7.2/fpm/php.ini
sed -i -e "s/Listen 443/Listen 8443/" /etc/php/7.3/fpm/php.ini
a2enmod rewrite
service apache2 start
service apache2 stop
service apache2 start
service nginx restart
php -v

echo "install mysql"
apt -y install mysql-server
#apt -y install mariadb-server mariadb-client
mysql_secure_installation

echo "phpmyadmin"
apt -y install phpmyadmin php-mbstring php-gettext
cp -R /etc/phpmyadmin/ $BACKUPFOLDER_EMPTY/
sed -i -e "s/Alias \/phpmyadmin/Alias \/dbase/" /etc/phpmyadmin/apache.conf
service apache2 stop
service apache2 start


echo "create user"
$SCRIPTS/users/input_useradd.sh


sed -i -e "s/ssl=1/ssl=0/" /etc/webmin/miniserv.conf
sed -i -e "s/port=10000/port=7000/" /etc/webmin/miniserv.conf
sed -i -e "s/listen=10000/listen=7000/" /etc/webmin/miniserv.conf
sed -i '$ a referers=wm.alixi.ru'  /etc/webmin/config
cp /my/scripts/.config/settings/webmin/apache/wm.alixi.ru.conf $APACHEAVAILABLE/wm.alixi.ru.conf

systemctl restart webmin
a2enmod proxy_http
a2ensite wm.alixi.ru
systemctl restart apache2


#--------------------------------------------
echo "step2"
echo "ufw settings"
ufw enable
ufw default allow outgoing
ufw default deny incoming
ufw allow 6666/tcp comment 'SSH'
ufw allow 80/tcp comment 'HTTP-Nginx'
ufw allow 443/tcp comment 'HTTPS-Nginx'
ufw allow 10081/tcp comment 'ProFTPd'
ufw allow 8080/tcp comment 'HTTP-Apache'
ufw allow 8443/tcp comment 'HTTPS-Apacne'
ufw allow 7000/tcp from 83.234.149.31 comment 'Webmin from Home'
ufw allow proto tcp from 83.234.149.31 to port 7000 comment 'Webmin from Home'
ufw allow 7000/tcp comment 'webmin'

echo "fail2ban"
apt install fail2ban
cp -R /etc/fail2ban/ $BACKUPFOLDER_EMPTY/

#wm.alixi.ru:7000
