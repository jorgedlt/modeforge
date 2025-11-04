# Cron Scheduling Example

This example demonstrates how to schedule a ModeForge mode using cron for automated weekly reports.

## Setup

1. Ensure the mode JSON has a `run.schedule` field:
   ```json
   {
     "name": "scheduled-report",
     "run": {
       "schedule": "0 9 * * MON",
       "trigger": "cron"
     }
   }
   ```

2. Run the scheduling script:
   ```bash
   ./scripts/schedule_mode.sh modes/scheduled-report.json
   ```

3. The script adds a cron job that runs every Monday at 9 AM.

## Cron Format

The schedule uses standard cron syntax:
- `0 9 * * MON`: At 9:00 AM every Monday
- `*/30 * * * *`: Every 30 minutes
- `0 2 * * 0`: Every Sunday at 2:00 AM

## Verification

Check your crontab:
```bash
crontab -l
```

You should see an entry like:
```
0 9 * * MON /path/to/modeforge/scripts/run_mode.sh /path/to/modeforge/modes/scheduled-report.json
```

## Logs

Output is logged to `logs/scheduled-report.log`.