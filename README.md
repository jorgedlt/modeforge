# ModeForge

[![Build Status](https://github.com/yourusername/modeforge/actions/workflows/validate.yml/badge.svg)](https://github.com/yourusername/modeforge/actions/workflows/validate.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A public collection of pre-built OpenCode mode templates (starter packs) that enable users to quickly deploy time-based, triggered, and workflow-oriented automation using [OpenCode](https://github.com/sst/opencode) and MCP tools.

## Overview

OpenCode modes are specialized configurations that define how the AI agent behaves for specific tasks, including custom prompts, temperature settings, tool access, and automation triggers. ModeForge provides ready-to-use JSON definitions to streamline setup and deployment of automated workflows.

## Features

- **10 ready-to-run mode templates** for common automation scenarios
- **Bash and MCP integration examples** for extended functionality
- **Scheduling and webhook examples** for time-based and event-driven execution
- **Extensible JSON structure** for easy customization and expansion

## Quick Start

```bash
git clone https://github.com/yourusername/modeforge.git
cd modeforge
./scripts/run_mode.sh modes/high-precision.json
```

## Mode List Summary

- **Scheduled Report Mode**: Runs on cron, generates summaries and reports from logs or data.
- **Webhook Trigger Mode**: Listens for API calls, runs specific commands or workflows on trigger.
- **High Precision Mode**: Low temperature setting for detailed, accurate reasoning tasks.
- **Low Cost Mode**: Uses cheaper models optimized for bulk processing and repetitive tasks.
- **Review Mode**: Performs code or document reviews with focused analysis tools.
- **Branching Skeleton**: AI decision tree runner for conditional workflows and branching logic.
- **Screen Capture Stub**: Integrates with external vision MCP tools for image-based automation.
- **Build/CI Agent Mode**: Automates build, test, and deployment cycles in CI/CD pipelines.
- **Data Analysis Mode**: Handles CSV/SQL data insights, queries, and visualization.
- **Maintenance Mode**: Runs cleanup tasks, log reviews, and system maintenance operations.

## Extending Modes

Modes are defined in JSON format with the following structure. Modify fields to customize behavior:

```json
{
  "name": "scheduled-report",
  "prompt": "Summarize logs and produce a weekly report.",
  "temperature": 0.3,
  "tools": ["shell", "git", "http"],
  "run": {
    "schedule": "0 9 * * MON",
    "trigger": "cron"
  }
}
```

- `name`: Unique identifier for the mode
- `prompt`: System prompt defining the agent's behavior
- `temperature`: Controls randomness (0.0-1.0, lower for precision)
- `tools`: Array of enabled tools (e.g., "shell", "git", "http", MCP tools)
- `run`: Automation configuration with schedule (cron format) and trigger type

## Contributing

We welcome contributions! To propose new mode types or improve existing ones:

1. Fork the repository
2. Create a feature branch (`git checkout -b new-mode-template`)
3. Add your mode JSON file to `modes/`
4. Update this README with the new mode description
5. Submit a pull request with a clear description of the changes

Please ensure all JSON files are syntactically valid and include comprehensive documentation.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.