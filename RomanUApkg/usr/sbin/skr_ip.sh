#!/bin/bash

# Отримати поточну дату і час у форматі року-місяця-дня години:хвилини:секунди
DATETIME=$(date "+%Y-%m-%d %H:%M:%S")

# Отримати IP-адресу клієнта, який підключається до SSH (змінна $SSH_CONNECTION)
IP=$(echo $SSH_CONNECTION | awk '{print $1}')

# Якщо $IP порожній, спробуємо використати інший метод для отримання IP
if [ -z "$IP" ]; then
  # Визначити IP за допомогою команди last
  IP=$(last -i | grep "still logged in" | awk '{print $3}')
fi

# Перевірити, чи отримано значення IP
if [ -n "$IP" ]; then
  # Записати дату, час і IP-адресу до файлу client_log.txt
  echo "$DATETIME - Connected: $IP" >> /usr/sbin/client_log.txt
else
  # Перевірити, чи не порожній файл (якщо він порожній - це відключення без попереднього підключення)
  if [ -s /user/sbin/client_log.txt ]; then
    echo "$DATETIME - Disconnected" >> /user/sbin/client_log.txt
  fi
fi
