#!/bin/bash
source /etc/profile
source ~/.bashrc
#Создание бэкапа всех баз на сервере
# $_1 - BACKUPPATH, $2-type, $3-$USER $4-$PASSWORD


if [ -n "$1" ] && [ -n "$2" ] 
then

		mysql -e "show databases;"
		d=`date +%Y%m%d`;
		dt=`date +%Y%m%d_%H%M`;

		#rm "BACKUPPATH/*gz" > /dev/null 2>&1

		echo -e "${COLOR_YELLOW}Список имеющихся баз данных на сервере: ${COLOR_NC}"
		databases=`mysql -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

	for db in $databases; do
		if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] ; then
			echo -e "Dumping database: $COLOR_YELLOW$db$COLOR_NC"
			
		case $2 in
			1)
				mysqldump --databases $db > $1$db.$dt.sql
				tar -czvf $1$db.$dt.sql.tar.gz $1$db.$dt.sql --remove-files
				;;
			2)
				mysqldump -u$3 -p$4 --databases $db > $1$db.$dt.sql
				tar -czvf $1$db.$dt.sql.tar.gz $1$db.$dt.sql --remove-files
				;;
			*)
				echo "Ошибка передачи параметров"
				;;
		esac		
			
		fi		
done
$MENU/menu_sql_backup.sh $1
  
fi




















