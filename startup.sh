#!/usr/bin/env bash

service cron start
systemctl start rsyslog
tail -f /var/log/cron.log