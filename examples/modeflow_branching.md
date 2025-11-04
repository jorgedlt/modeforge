# ModeFlow Branching Example

This example illustrates conditional workflows and decision trees in ModeForge modes.

## Branching Logic

The `branching-skeleton` mode supports conditional execution based on inputs or conditions.

Example JSON:
```json
{
  "name": "branching-skeleton",
  "prompt": "Evaluate the input and choose the appropriate action.",
  "run": {
    "trigger": "manual",
    "branch": {
      "condition": "input > threshold",
      "true": "action1",
      "false": "action2"
    }
  }
}
```

## Usage

1. Run the mode manually:
   ```bash
   ./scripts/run_mode.sh modes/branching-skeleton.json
   ```

2. Provide input when prompted by the OpenCode agent.

3. The agent evaluates the condition and executes the corresponding branch.

## Advanced Branching

For more complex logic, extend the JSON with nested conditions or multiple branches:
```json
{
  "run": {
    "branch": {
      "condition": "status == 'error'",
      "true": {
        "action": "notify_admin",
        "branch": {
          "condition": "severity > 5",
          "true": "escalate",
          "false": "log_only"
        }
      },
      "false": "continue_normal"
    }
  }
}
```

## Integration

Combine with scheduling or webhooks for automated decision-making workflows.