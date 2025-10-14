# ATXP Plugin for Claude Code

This plugin provides seamless access to all ATXP MCP servers with simplified authentication and automatic proxy billing.

## Installation

Install this plugin from the ATXP marketplace:

```bash
/plugin marketplace add atxp-dev/claude
/plugin install kitchen-sink@atxp
```

## Setup

Run the setup command with your ATXP connection string (from your [ATXP dashboard](https://atxp.ai)):

```bash
/setup <connection-string>
```

This will merge the ATXP MCP servers into your project's `.mcp.json` (creating it if missing).

## Available MCP Servers

This plugin includes these official ATXP MCP servers (HTTP):

### atxp-browse
Browser automation and capture (screenshots, recordings).

### atxp-crawl
Scrape and crawl websites to extract content.

### atxp-search
Web search with structured results.

### atxp-research
Deep research with synthesized answers and sources.

### atxp-database
Create Postgres databases and run SQL.

### atxp-filestore
Store, retrieve, and manage files.

### atxp-image
Generate images from prompts.

### atxp-music
Create music from lyrics and styles.

### atxp-video
Generate videos from text prompts.

### atxp-code
Execute code in a sandbox (JS, Python, TS).

## Technical Details

- All MCP servers are configured as remote HTTP servers per Claude MCP docs

## Documentation

- [ATXP Documentation](https://docs.atxp.ai/atxp)
- [ATXP MCP Proxy](https://docs.atxp.ai/proxy)
- [Claude Code Plugins](https://docs.claude.com/en/docs/claude-code/plugins)

