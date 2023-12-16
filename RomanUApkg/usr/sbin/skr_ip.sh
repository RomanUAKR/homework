#!/bin/bash

DATETIME=$(date "+%Y-%m-%d %H:%M:%S")
IP=$(echo $SSH_CONNECTION | awk '{print $1}')

if [ -z "$IP" ]; then
  IP=$(last -i | grep "still logged in" | awk '{print $3}')
fi

if [ -n "$IP" ]; then
  echo "$DATETIME - Connected: $IP" >> /usr/sbin/client_log.txt
else
  if [ -s /usr/sbin/client_log.txt ]; then
    echo "$DATETIME - Disconnected" >> /usr/sbin/client_log.txt
  fi
fi

# Вивести унікальні записи "дата час конект IP"
awk '!seen[$0]++' /usr/sbin/client_log.txt | awk '{if (NF>1) {for (i=2; i<=NF; i++) {print $1, $2, $3, " Connected:", $i; echo "  дата час  конект " $i, $1, $2, $3}}}' >> /usr/sbin/unique_client_log.txt
