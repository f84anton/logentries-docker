#!/bin/bash

export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

if [[ -z "$LE_ACCOUNT_KEY" ]] || [[ -z "$LE_HOSTNAME" ]]; then
 echo Please provide env variables: LE_ACCOUNT_KEY, LE_HOSTNAME
 exit 1
fi

PULL_SS_CONFIG=${LE_PULL_CONFIG:-False}

ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime

echo Register this agent $(date)
le register --account-key="$LE_ACCOUNT_KEY" --hostname="$LE_HOSTNAME" --name="$LE_HOSTNAME" --force --pull-server-side-config="$PULL_SS_CONFIG"

echo Start logentries $(date)
exec le-monitor
