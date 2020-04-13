# gorcom-balance
Простой скрипт проверяющий баланс в личном кабинете gorcom.ru

## First start
- Настраиваем postfix/sendmail/etc на отправку почты
- Задаем login и pass в balance.py
- Задаем минимальный баланс в parse.sh (34 строка)
- Задаем email адреса в parse.sh куда слать allert
- Создаем бота в телеграм через @BotFather
- Узнаем свой chat ID в телеграме через @my_id_bot
- Задаем token и chat ID в telegram.sh

## Crontab
Для исполнения скрипта добавьте в crontab условия запуска. Пример:
```shell
* 12 * * * /home/gorcom-balance/parse.sh (каждый день в 12:00 утра)
* 20 * * * /home/gorcom-balance/parse.sh (каждый день в 20:00 вечера)
```

## Screenshots
![email](https://github.com/EvilBox/gorcom-balance/raw/master/docs/email.png)
![tg](https://github.com/EvilBox/gorcom-balance/raw/master/docs/telegram.png)
