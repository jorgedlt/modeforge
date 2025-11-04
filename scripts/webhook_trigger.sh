#!/bin/bash

# ModeForge Webhook Trigger Script
# Usage: ./webhook_trigger.sh <mode_json_file> <port>

if [ $# -lt 1 ]; then
    echo "Usage: $0 <mode_json_file> [port]"
    exit 1
fi

MODE_FILE=$1
PORT=${2:-8080}

if [ ! -f "$MODE_FILE" ]; then
    echo "Mode file not found: $MODE_FILE"
    exit 1
fi

NAME=$(jq -r '.name' "$MODE_FILE")
ENDPOINT=$(jq -r '.run.endpoint // "/trigger"' "$MODE_FILE")

echo "Starting webhook server for mode '$NAME' on port $PORT, endpoint $ENDPOINT"

# Simple webhook server using netcat (nc) - for demo purposes
# In production, use a proper web server like nginx or a script with curl
while true; do
    echo "Listening on port $PORT..."
    REQUEST=$(nc -l -p $PORT -q 1)
    if echo "$REQUEST" | grep -q "POST $ENDPOINT"; then
        echo "Webhook triggered at $(date)"
        ./scripts/run_mode.sh "$MODE_FILE" &
    fi
done