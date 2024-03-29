#!/bin/bash
source /etc/profile
source ~/.bashrc
echo ''
echo -e "${COLOR_GREEN} ===Просмотр списка бэкапов===${COLOR_NC}"

echo '1: Бэкапы за сегодняшний день'
echo '2: Бэкапы за вчерашний день'
echo '3: Бэкапы за последнюю неделю'
echo '4: Указать дату'
echo '5: Указать диапазон дат'


echo '0: Назад'
echo '/: Выход'
echo ''
echo -n 'Выберите пункт меню:'
read item
case "$item" in
        1) $SCRIPTS/system/backup/show/show_today.sh $1
           $MENU/menu_backup.sh $1
            ;;
		2) $SCRIPTS/system/backup/show/show_yestoday.sh $1
           $MENU/menu_backup.sh $1
            ;;
		3) $SCRIPTS/system/backup/show/show_week.sh $1
           $MENU/menu_backup.sh $1
            ;;
		4) $SCRIPTS/system/backup/show/show_range.sh $1
           $MENU/menu_backup.sh $1
            ;;
		5) $SCRIPTS/system/backup/show/show_range_input.sh $1
           $MENU/menu_backup.sh $1
            ;;
        
        0)  echo ''
            $MYFOLDER/scripts/menu $1
            ;;
        /) echo "Выход..."
            exit 0
            ;;
esac