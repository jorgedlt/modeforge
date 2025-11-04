#!/bin/bash

# ModeForge Run Mode Script
# Usage: ./run_mode.sh <mode_json_file>

if [ $# -ne 1 ]; then
    echo "Usage: $0 <mode_json_file>"
    exit 1
fi

MODE_FILE=$1

if [ ! -f "$MODE_FILE" ]; then
    echo "Mode file not found: $MODE_FILE"
    exit 1
fi

# Parse JSON using jq (assuming jq is installed)
NAME=$(jq -r '.name' "$MODE_FILE")
PROMPT=$(jq -r '.prompt' "$MODE_FILE")
TEMPERATURE=$(jq -r '.temperature' "$MODE_FILE")
TOOLS=$(jq -r '.tools | join(",")' "$MODE_FILE")

echo "Running mode: $NAME"
echo "Prompt: $PROMPT"
echo "Temperature: $TEMPERATURE"
echo "Tools: $TOOLS"
echo "Log started at $(date)" >> "logs/${NAME}.log"

# Run OpenCode in non-interactive mode with the prompt
# Note: Adjust model and agent as needed; this assumes default setup
opencode run "$PROMPT" --model "anthropic/claude-sonnet-4-20250514" >> "logs/${NAME}.log" 2>&1

echo "Mode execution completed. Check logs/${NAME}.log for output."