#!/bin/bash
#Получаем текущую директорию что бы не хардкодить путь до .py файла и обертки telegram бота
DIR=$(cd $(dirname "${BASH_SOURCE[0]}");pwd)
#Получаем текущий баланс и дробим запись на рубли и копейки
full_money=$(python3 $DIR/balance.py | grep -A1 Баланс | tail -n +2 | cut -f2- -d'>' | rev | cut -f2- -d'<' | rev)
whole_money=$(echo $full_money | awk -v FS='.' '{print $1}')
partial_money=$(echo $full_money | awk -v FS='.' '{print $2}')

#Получаем рекомендуемый платеж и дробим запись на рубли и копейки
full_rec_pay=$(python3 $DIR/balance.py | grep -A1 'Рекомендуемый платеж' | tail -n +2 | cut -f2- -d'>' | rev | cut -f2- -d'<' | rev)
whole_rec_pay=$(echo $full_rec_pay | awk -v FS='.' '{print $1}')
partial_rec_pay=$(echo $full_rec_pay | awk -v FS='.' '{print $2}')

#или так
#python3 $DIR/balance.py | grep -A1 'utm-cell' | awk -v FS='<|>' '{print $3}' | paste - - #парсим ВСЕ данные (можно использовать для таблицы/базы)
#python3 $DIR/balance.py | grep -A1 Баланс | awk -v FS='<|>' '{print $3}' | tail -1 #парсим покороче (но надо править py скрипт и вывод в нем)

#Текст и тема для email
message_intro="Уважаемый пользователь услуг оператора связи Горсеть!"
message_money="Обращаем внимание, что баланс Вашего счёта приближается к порогу отключения и составляет $whole_money рублей и $partial_money копеек. Пожалуйста пополните баланс"
message_rec_pay="Рекомендуемый платеж составляет: $whole_rec_pay рублей и $partial_rec_pay копеек"
message_sing="Это письмо сформировано автоматически. Пожалуйста, не отвечайте на него. С ❤️ ваша Горсеть"
subject="Баланс Горсеть"

#Текст и тема для telegram
tg_message="Баланс счёта составляет $whole_money рублей и $partial_money копеек."
tg_subject="⚠️ Баланс Горсеть"

#Если цифра меньше 30 то пишем на почту/мессенджер иначе закрываемся
if [[ "$whole_money" > "30" ]]; then
exit 0
else
printf "$message_intro\n$message_money\n$message_rec_pay\n$message_sing" | mail -s "$subject" roman@allury.tech && \
printf "$message_intro\n$message_money\n$message_rec_pay\n$message_sing" | mail -s "$subject" user@me.com && \
$DIR/telegram.sh "$tg_subject" "$tg_message" > /dev/null 2>&1
fi
