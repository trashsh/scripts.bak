#!/bin/bash
source /etc/profile
source ~/.bashrc
echo ''
echo -e "${COLOR_GREEN} ===Резервное копирование баз данных===${COLOR_NC}"

echo '+1: Создать копию всех баз всего сервера'
echo '2: Создать копию всех баз конкретного пользователя'
echo '3: Создать копию одной базы'
echo '4: Восстановить из бэкапа сервер баз данных'
echo '5: Восстановить из бэкапа все базы пользователя'
echo '6: Восстановить из бэкапа одну базу'

echo '0: Назад'
echo '/: Выход'
echo ''
echo -n 'Выберите пункт меню:'
read item
case "$item" in
        1) sudo $SCRIPTS/mysql/backup_all_bases.sh $1
            ;;
        2) $SCRIPTS/mysql/backup_all_bases_user.sh $1
            ;;
		3) $SCRIPTS/mysql/mysql_backup_base.sh $1
            ;;
		4) $SCRIPTS/mysql/ $1
            ;;
		5) $SCRIPTS/mysql/ $1
            ;;
		6) $SCRIPTS/mysql/ $1
            ;;

        0)  echo ''
            $MENU/menu_sql.sh $1
            ;;
        /) echo "Выход..."
            exit 0
            ;;
esac