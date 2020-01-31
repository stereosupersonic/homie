#!/bin/bash

# Start the run once job.
echo "Docker container has been started"

declare -p | grep -Ev 'BASHOPTS|BASH_VERSINFO|EUID|PPID|SHELLOPTS|UID' > /container.env

# Setup a cron test schedule
echo "SHELL=/bin/bash
BASH_ENV=/container.env
* * * * * /app/run.sh >> /var/log/cron.log 2>&1
# This extra line makes it a valid cron" > scheduler.txt
crontab scheduler.txt

echo "write whenever cront entries"
bundle exec whenever --update-crontab

echo "start cron service"
service cron start

echo "run migrations"
bundle exec rails db:migrate

echo "start rails server"
rm -f /app/tmp/pids/server.pid 
bundle exec rails server -b 0.0.0.0 -p 3000