#! /bin/bash

# "0 * * * * /create_backup.sh" every hour

# "* 3 * * * /create_backup.sh" every 24 hours, at 3 am.

# "0 8 * * 1 /create_backup.sh" every Monday at 8 am.

cron_job="* * * * * /create_backup.sh"
{
    env | grep MYSQL; echo "$cron_job";
} | crontab -