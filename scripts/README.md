# ModeForge Scripts

This directory contains Bash scripts for running, scheduling, and triggering ModeForge modes.

## Scripts

### run_mode.sh

Runs a mode in non-interactive mode using OpenCode.

**Usage:**
```bash
./run_mode.sh modes/high-precision.json
```

- Parses the JSON mode file
- Extracts prompt, temperature, and tools
- Runs `opencode run` with the prompt
- Logs output to `logs/<mode_name>.log`

### schedule_mode.sh

Schedules a mode to run via cron based on the `run.schedule` field.

**Usage:**
```bash
./schedule_mode.sh modes/scheduled-report.json
```

- Parses the schedule from the mode JSON
- Adds a cron job to run the mode at the specified time

**Note:** Requires cron access. Handle crontab modifications carefully.

### webhook_trigger.sh

Starts a simple webhook server to trigger modes on HTTP requests.

**Usage:**
```bash
./webhook_trigger.sh modes/webhook-trigger.json 8080
```

- Listens on the specified port (default 8080)
- Triggers the mode when a POST request hits the endpoint (default /trigger)
- Uses netcat for simplicity; consider a proper web server for production

## Requirements

- `jq` for JSON parsing
- `opencode` CLI installed
- `netcat` (nc) for webhook server
- Cron for scheduling

## Logs

All script outputs are logged to the `logs/` directory (create if needed).