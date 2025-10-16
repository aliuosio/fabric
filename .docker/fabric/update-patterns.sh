#!/bin/bash
set -e
echo "$(date): Running Fabric update..." >> /var/log/cron.log
fabric --updatepatterns >> /var/log/cron.log 2>&1
fabric --updatestrategies >> /var/log/cron.log 2>&1