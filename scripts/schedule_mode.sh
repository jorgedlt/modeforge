#!/bin/bash

# ModeForge Schedule Mode Script
# Usage: ./schedule_mode.sh <mode_json_file>

if [ $# -ne 1 ]; then
    echo "Usage: $0 <mode_json_file>"
    exit 1
fi

MODE_FILE=$1

if [ ! -f "$MODE_FILE" ]; then
    echo "Mode file not found: $MODE_FILE"
    exit 1
fi

# Parse schedule from JSON
SCHEDULE=$(jq -r '.run.schedule' "$MODE_FILE")

if [ "$SCHEDULE" == "null" ]; then
    echo "No schedule defined in mode file."
    exit 1
fi

NAME=$(jq -r '.name' "$MODE_FILE")

# Add to crontab (example - requires sudo or user crontab)
# This is a simplified example; in production, handle crontab management carefully
CRON_JOB="$SCHEDULE $(pwd)/scripts/run_mode.sh $(pwd)/$MODE_FILE"

echo "Adding cron job: $CRON_JOB"
(crontab -l ; echo "$CRON_JOB") | crontab -

echo "Scheduled mode '$NAME' with cron: $SCHEDULE"