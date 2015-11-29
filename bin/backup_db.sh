#!/usr/bin/env bash

set -e

SWITCH="\033["
NORMAL="${SWITCH}0m"
YELLOW="${SWITCH}1;33m"

execute() {
    local command=$1
    echo
    echo -e " ====> Running ${YELLOW} $command ${NORMAL}"
    echo
    eval $command
    return $?
}

file=/tmp/`date "+%Y-%m-%dT%H:%M:%S"`.dump
execute "PGPASSWORD=$BLINK_DATABASE_PASSWORD pg_dump -U blink -Fc blink_production > $file"
execute "s3cmd put $file s3://blink-prod/pgbackups/production/"
execute "curl https://nosnch.in/c77b6062f2"
