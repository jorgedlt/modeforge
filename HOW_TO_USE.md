# How to Use ModeForge with OpenCode

This guide provides step-by-step instructions for setting up and using ModeForge mode templates with OpenCode for automated AI workflows.

## Prerequisites

Before using ModeForge, ensure you have:

- **OpenCode CLI** installed ([installation guide](https://opencode.ai/docs/))
- **jq** for JSON parsing (`sudo apt install jq` on Ubuntu/Debian)
- **netcat** for webhook testing (`sudo apt install netcat` on Ubuntu/Debian)
- **Git** for cloning repositories
- **Cron** access for scheduling (most Linux systems have this by default)

## Installation

1. **Clone the ModeForge repository:**
   ```bash
   git clone https://github.com/jorgedlt/modeforge.git
   cd modeforge
   ```

2. **Make scripts executable:**
   ```bash
   chmod +x scripts/*.sh
   ```

3. **Create logs directory:**
   ```bash
   mkdir logs
   ```

## OpenCode Configuration

1. **Authenticate with a provider:**
   ```bash
   opencode auth login
   ```
   Select your preferred LLM provider (e.g., Anthropic, OpenAI).

2. **Verify installation:**
   ```bash
   opencode --version
   opencode models  # List available models
   ```

## Running Modes Manually

Use the `run_mode.sh` script to execute a mode template:

```bash
./scripts/run_mode.sh modes/high-precision.json
```

This will:
- Parse the JSON configuration
- Run OpenCode with the specified prompt and settings
- Log output to `logs/high-precision.log`

### Example Output
```
Running mode: high-precision
Prompt: You are a high-precision agent. Provide detailed, accurate reasoning for complex tasks.
Temperature: 0.1
Tools: read,edit,grep
Log started at Mon Nov 03 14:30:00 UTC 2025
[OpenCode output here]
Mode execution completed. Check logs/high-precision.log for output.
```

## Scheduling Modes with Cron

Automate mode execution using cron:

1. **Schedule a mode:**
   ```bash
   ./scripts/schedule_mode.sh modes/scheduled-report.json
   ```

2. **Verify cron job:**
   ```bash
   crontab -l
   ```

   You should see an entry like:
   ```
   0 9 * * MON /path/to/modeforge/scripts/run_mode.sh /path/to/modeforge/modes/scheduled-report.json
   ```

3. **Remove cron job (if needed):**
   Edit crontab and remove the line:
   ```bash
   crontab -e
   ```

## Webhook Triggering

Set up event-driven mode execution:

1. **Start webhook server:**
   ```bash
   ./scripts/webhook_trigger.sh modes/webhook-trigger.json 8080
   ```

2. **Trigger from another terminal:**
   ```bash
   curl -X POST http://localhost:8080/api/trigger
   ```

3. **Stop server:**
   Press `Ctrl+C` in the server terminal.

### Production Setup

For production webhook servers, consider:
- Using a proper web server (nginx, Apache)
- Adding HTTPS with certificates
- Implementing authentication tokens
- Running as a system service

## Customizing Modes

### Modifying Existing Modes

1. **Edit a mode JSON file:**
   ```bash
   nano modes/high-precision.json
   ```

2. **Adjust parameters:**
   - `temperature`: 0.0-1.0 (lower for precision)
   - `tools`: Add/remove available tools
   - `prompt`: Customize the system prompt
   - `run`: Modify triggers and schedules

3. **Test changes:**
   ```bash
   ./scripts/run_mode.sh modes/high-precision.json
   ```

### Creating New Modes

1. **Copy an existing mode:**
   ```bash
   cp modes/high-precision.json modes/my-custom-mode.json
   ```

2. **Edit the new file:**
   ```json
   {
     "name": "my-custom-mode",
     "prompt": "You are a specialized agent for [your task].",
     "temperature": 0.5,
     "tools": ["shell", "read", "edit"],
     "run": {
       "trigger": "manual"
     }
   }
   ```

3. **Test the new mode:**
   ```bash
   ./scripts/run_mode.sh modes/my-custom-mode.json
   ```

## MCP Integration

ModeForge supports MCP (Model Context Protocol) tools for extended functionality:

1. **Configure MCP servers in OpenCode:**
   Create or edit `~/.config/opencode/config.json`:
   ```json
   {
     "mcpServers": {
       "sql": {
         "command": "npx",
         "args": ["-y", "@modelcontextprotocol/server-sqlite", "--db-path", "/path/to/db"]
       }
     }
   }
   ```

2. **Use MCP tools in modes:**
   ```json
   {
     "name": "data-analysis",
     "tools": ["shell", "read", "mcp-sql"],
     "run": {
       "trigger": "manual"
     }
   }
   ```

3. **Available MCP tools:**
   - `mcp-sql`: Database operations
   - `mcp-vision`: Image analysis
   - `mcp-web`: Web scraping
   - `mcp-filesystem`: Advanced file operations

## Branching and Conditional Logic

For decision-tree workflows:

1. **Use branching-skeleton mode:**
   ```bash
   ./scripts/run_mode.sh modes/branching-skeleton.json
   ```

2. **Provide input when prompted by OpenCode.**

3. **The agent evaluates conditions and executes branches.**

## Troubleshooting

### Common Issues

1. **"jq: command not found"**
   - Install jq: `sudo apt install jq`

2. **"opencode: command not found"**
   - Ensure OpenCode is installed and in PATH
   - Re-run installation: `curl -fsSL https://opencode.ai/install | bash`

3. **Webhook server not responding**
   - Check if port 8080 is available: `netstat -tlnp | grep 8080`
   - Try a different port: `./scripts/webhook_trigger.sh modes/webhook-trigger.json 8081`

4. **Cron jobs not running**
   - Check cron service: `sudo systemctl status cron`
   - Verify crontab syntax: `crontab -l`
   - Check logs: `grep CRON /var/log/syslog`

5. **Permission denied on scripts**
   - Make executable: `chmod +x scripts/*.sh`

### Logs and Debugging

- **Mode execution logs:** `logs/<mode_name>.log`
- **OpenCode verbose output:** Add `--print-logs` to opencode commands
- **Cron logs:** `grep CRON /var/log/syslog`

### Getting Help

- **OpenCode documentation:** https://opencode.ai/docs
- **ModeForge issues:** https://github.com/jorgedlt/modeforge/issues
- **Community:** https://opencode.ai/discord

## Advanced Usage

### Integrating with CI/CD

Add ModeForge to your pipeline:

```yaml
# .github/workflows/ci.yml
- name: Run ModeForge analysis
  run: |
    git clone https://github.com/jorgedlt/modeforge.git
    cd modeforge
    ./scripts/run_mode.sh modes/review-mode.json
```

### Custom Scripts

Extend functionality by modifying the Bash scripts or creating new ones based on the examples in `scripts/`.

### Security Considerations

- Store API keys securely (use OpenCode's auth system)
- Limit tool permissions in sensitive environments
- Use HTTPS for webhook endpoints
- Regularly update OpenCode and dependencies

## Examples in Action

See the `examples/` directory for detailed walkthroughs:
- `cron_example.md`: Setting up scheduled reports
- `api_trigger_example.md`: Webhook automation
- `modeflow_branching.md`: Conditional workflows
- `mcp_extension_example.md`: MCP tool integration

Start with simple manual runs, then progress to scheduling and webhooks as you become comfortable with the system.