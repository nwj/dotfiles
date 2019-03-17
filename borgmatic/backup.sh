#!/bin/bash

# To automate backups every hour:
# crontab -e
# 0 * * * * /path/to/backup.sh


# Set these as needed
BORG_PATH=/usr/local/bin
BORG_CMD=borgmatic
RUN_PATH=$HOME
PATH_TO_CONFIG=$HOME/dotfiles/borgmatic/config.yaml
LOG_FILE=$HOME/borg.log

PATH=$PATH:$BORG_PATH
cd $RUN_PATH
echo "$(date) - Starting backup." >> $LOG_FILE
$BORG_CMD -c $PATH_TO_CONFIG --verbosity 1 >> $LOG_FILE 2>&1
echo "$(date) - Backup complete." >> $LOG_FILE
