#!/bin/bash

echo "Starting crontab..."

/crontab.sh

echo "Crontab is running..."

exec "cron" "-f"