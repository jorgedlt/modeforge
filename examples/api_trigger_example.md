# API Trigger Example

This example shows how to trigger a ModeForge mode via webhook for event-driven automation.

## Setup

1. Configure the mode with webhook trigger:
   ```json
   {
     "name": "webhook-trigger",
     "run": {
       "trigger": "webhook",
       "endpoint": "/api/trigger"
     }
   }
   ```

2. Start the webhook server:
   ```bash
   ./scripts/webhook_trigger.sh modes/webhook-trigger.json 8080
   ```

3. The server listens on port 8080 for POST requests to `/api/trigger`.

## Triggering

Send a POST request to trigger the mode:
```bash
curl -X POST http://localhost:8080/api/trigger
```

Or from another system:
```bash
curl -X POST https://your-server.com:8080/api/trigger
```

## Integration

Integrate with services like GitHub webhooks, CI/CD pipelines, or monitoring systems to trigger modes on events.

## Security

For production, add authentication:
- Use HTTPS
- Implement API keys or tokens
- Validate request sources

## Logs

Webhook triggers and mode executions are logged to `logs/webhook-trigger.log`.