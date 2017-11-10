#!/bin/bash

export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

if [[ -z "$LE_TOKEN" ]]; then
 echo Please provide env variable LE_TOKEN with logentries.com log token
 exit 1
fi

LE_HOST=${LE_API_HOST:-api.logentries.com}
LE_PORT=${LE_API_PORT:-20000}

ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime

journalctl \
--since "$(date +"%F %H:%M")" -o json --boot -f | \
jq \ 
-c '{timestamp:.__REALTIME_TIMESTAMP,time:.__REALTIME_TIMESTAMP | tonumber | ( . / 1000000 ) | strftime("%Y-%m-%dT%H:%M:%S+0000"),host:._HOSTNAME,unit:._SYSTEMD_UNIT,message_raw: .MESSAGE, message_parsed: ( try ( .MESSAGE | fromjson ) catch false)} | {timestamp:.timestamp, time:.time, host:.host, unit:.unit, message:(if .message_parsed == false then .message_raw else .message_parsed end)}' | \
awk \
-v token=$LE_TOKEN '{ print token,$0; fflush(); }' | \
ncat \
--ssl "$LE_HOST" "$LE_PORT"
