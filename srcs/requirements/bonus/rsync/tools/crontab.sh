#! /bin/bash

# "0 8 * * 1 /create_backup.sh" Jeden Montag um 8

cron_job="0 8 * * 1 /create_backup.sh"
{
    env | grep MYSQL; echo "$cron_job";
} | crontab -