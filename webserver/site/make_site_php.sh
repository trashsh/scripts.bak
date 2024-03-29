#!/bin/bash
#добавление сайта php/html
source /etc/profile
source ~/.bashrc
user=$USER
#$1-$USERNAME $2 - домен ($DOMAIN), $3 - имя пользователя, $4 - путь к папке с сайтом,  $5 - шаблон виртуального хоста apache, $6 - шаблон виртуального хоста nginx

#проверка на наличие параметров запуска
if [ -n "$1" ] && [ -n "$2" ] && [ -n "$3" ] && [ -n "$4" ] && [ -n "$5" ] && [ -n "$6" ]
then
        #make user
        echo "Добавление веб пользователя $3_$2 с домашним каталогом: $4 для домена $2"
        sudo mkdir -p $4		
        sudo useradd $3_$2 -N -d $4 -m -s /bin/false
        sudo adduser $3_$2 www-data
		echo -e "${COLOR_YELLOW}Установка пароля для ftp-пользователя \"$3\"${COLOR_NC}"
        sudo passwd $3_$2
        sudo cp -R /etc/skel/* $4

       #copy index.php
       sudo cp $TEMPLATES/index_php/index.php $4/$WWWFOLDER/index.php
       sudo cp $TEMPLATES/index_php/underconstruction.jpg $4/$WWWFOLDER/underconstruction.jpg
       sudo grep '#__DOMAIN' -P -R -I -l  $4/$WWWFOLDER/index.php | sudo xargs sed -i 's/#__DOMAIN/'$2'/g' $4/$WWWFOLDER/index.php
 #       sed -i 's/#__DOMAIN/$2' $4/$WWWFOLDER/index.php
 

       #nginx
       sudo cp -rf $TEMPLATES/nginx/$6 /etc/nginx/sites-available/"$3"_"$2".conf
	   sudo chmod 644 /etc/nginx/sites-available/"$3"_"$2".conf
       sudo echo "Замена переменных в файле /etc/nginx/sites-available/"$3"_"$2".conf"
       sudo grep '#__DOMAIN' -P -R -I -l  /etc/nginx/sites-available/"$3"_"$2".conf | sudo xargs sed -i 's/#__DOMAIN/'$2'/g' /etc/nginx/sites-available/"$3"_"$2".conf
	   sudo grep '#__USER' -P -R -I -l  /etc/nginx/sites-available/"$3"_"$2".conf | sudo xargs sed -i 's/#__USER/'$3'/g' /etc/nginx/sites-available/"$3"_"$2".conf
       sudo grep '#__PORT' -P -R -I -l  /etc/nginx/sites-available/"$3"_"$2".conf | sudo xargs sed -i 's/#__PORT/'$HTTPNGINXPORT'/g' /etc/nginx/sites-available/"$3"_"$2".conf
       sudo grep '#__HOMEPATHWEBUSERS' -P -R -I -l  /etc/nginx/sites-available/"$3"_"$2".conf | sudo xargs sed -i 's/'#__HOMEPATHWEBUSERS'/\/home\/webusers/g' /etc/nginx/sites-available/"$3"_"$2".conf

       sudo  ln -s /etc/nginx/sites-available/"$3"_"$2".conf /etc/nginx/sites-enabled/"$3"_"$2".conf
       sudo  systemctl reload nginx

        #apache2
        sudo cp -rf $TEMPLATES/apache2/$5 /etc/apache2/sites-available/"$3"_"$2".conf
		chmod 644 /etc/apache2/sites-available/"$3"_"$2".conf
        sudo echo "Замена переменных в файле /etc/apache2/sites-available/"$3"_"$2".conf"
        sudo grep '#__DOMAIN' -P -R -I -l  /etc/apache2/sites-available/"$3"_"$2".conf | sudo xargs sed -i 's/#__DOMAIN/'$2'/g' /etc/apache2/sites-available/"$3"_"$2".conf
		sudo grep '#__USER' -P -R -I -l  /etc/apache2/sites-available/"$3"_"$2".conf | sudo xargs sed -i 's/#__USER/'$3'/g' /etc/apache2/sites-available/"$3"_"$2".conf
        sudo grep '#__HOMEPATHWEBUSERS' -P -R -I -l  /etc/apache2/sites-available/"$3"_"$2".conf | sudo xargs sed -i 's/#__HOMEPATHWEBUSERS/\/home\/webusers/g' /etc/apache2/sites-available/"$3"_"$2".conf
        sudo grep '#__PORT' -P -R -I -l  /etc/apache2/sites-available/"$3"_"$2".conf | sudo xargs sed -i 's/#__PORT/'$HTTPAPACHEPORT'/g' /etc/apache2/sites-available/"$3"_"$2".conf

        sudo a2ensite "$3"_"$2".conf
        sudo service apache2 reload    
		
        #chmod
        sudo find $4 -type d -exec chmod 755 {} \;
        sudo find $4/$WWWFOLDER -type d -exec chmod 755 {} \;
        sudo find $4 -type f -exec chmod 644 {} \;
        sudo find $4/$WWWFOLDER -type f -exec chmod 644 {} \;
        sudo find $4/logs -type f -exec chmod 644 {} \;

        sudo chown -R $3:www-data $4/logs
        sudo chown -R $3:www-data $4/$WWWFOLDER
        sudo chown -R $3:www-data $4/tmp
		
		cd $4/$WWWFOLDER
		echo -e "\033[32m" Инициализация Git "\033[0;39m"
		git init
		git add .
		git commit -m "initial commit"
		
		echo -e "==========================================="
		echo -e "Сайт доступен по адресу: ${COLOR_YELLOW} Параметры подключения к сайту ${COLOR_NC} (nginx)"
        echo -e "Сайт доступен по адресу: ${COLOR_YELLOW} http://"$2" ${COLOR_NC} (nginx)"
        echo -e "Сайт доступен по адресу: ${COLOR_YELLOW} http://"$2":8080 ${COLOR_NC} (apache)"
		echo -e "Сервер FTP: ${COLOR_YELLOW} "$2":10081 ${COLOR_NC}"
		echo -e "FTP User: ${COLOR_YELLOW} $3_$2 ${COLOR_NC}"
		echo -e "PhpMyAdmin: ${COLOR_YELLOW} https://conf.mmgx.ru/dbase ${COLOR_NC}"
		echo -e "Adminer: ${COLOR_YELLOW} https://conf.mmgx.ru/a ${COLOR_NC}"
		echo -e "MYSQL User: ${COLOR_YELLOW} $3_$2 ${COLOR_NC}"
		echo -e "MYSQL DB: ${COLOR_YELLOW} $3_$2 ${COLOR_NC}"
		
		$SCRIPTS/menu $1

else
    echo "Возможные варианты шаблонов apache:"
    ls $TEMPLATES/apache2/
    echo "Возможные варианты шаблонов nginx:"
    ls $TEMPLATES/nginx/
    echo "--------------------------------------"
    echo "Параметры запуска не найдены. Необходимы параметры: домен, имя пользователя,путь к папке с сайтом,название шаблона apache,название шаблона nginx."
    echo "Например $0 domain.ru user /home/webusers/domain.ru php.conf php.conf"
    echo -n "Для запуска основного меню напишите ${COLOR_BLUE} \"y\" ${COLOR_NC}, для выхода - любой другой символ: "
    read item
    case "$item" in
        y|Y) echo "Ввели «y», продолжаем..."
            $SCRIPTS/menu.sh $1
            ;;
        *) echo "Выход..."
            exit 0
            ;;
    esac
fi


