# MCP Extension Example

This example demonstrates integrating ModeForge modes with MCP (Model Context Protocol) tools for extended functionality.

## MCP Tools

MCP allows connecting to external tools and services. ModeForge modes can specify MCP tools in the `tools` array.

Example mode using MCP:
```json
{
  "name": "data-analysis",
  "prompt": "Analyze the provided data using SQL queries and generate insights.",
  "tools": ["shell", "read", "mcp-sql", "mcp-chart"],
  "run": {
    "trigger": "manual"
  }
}
```

## Setup

1. Install MCP server for the desired tool (e.g., SQL database connector).
2. Configure OpenCode to connect to the MCP server.
3. Specify the MCP tool in the mode's `tools` array.

## Usage

Run the mode:
```bash
./scripts/run_mode.sh modes/data-analysis.json
```

The OpenCode agent can now use the MCP tools for enhanced capabilities, such as querying databases or generating charts.

## Available MCP Tools

- `mcp-sql`: Database querying
- `mcp-vision`: Image analysis
- `mcp-web`: Web scraping
- `mcp-filesystem`: Advanced file operations

## Custom MCP Servers

Develop custom MCP servers for specific needs:
- Connect to proprietary APIs
- Integrate with internal tools
- Extend functionality for domain-specific tasks

## Configuration

Add MCP server configuration to your OpenCode config:
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

## Logs

MCP interactions are logged along with mode execution in `logs/<mode_name>.log`.