#!/bin/bash

token='83635473494:cMXHlmfJW70nSb3DQFCA9FrZKneTyIpfM5T'
chat="198654813"
subj="$1"
message="$2"

/usr/bin/curl -s --header 'Content-Type: application/json' \
     --request 'POST' \
     --data "{\"chat_id\":\"${chat}\",\"text\":\"${subj}\n${message}\"}" \
     "https://api.telegram.org/bot${token}/sendMessage"
