# ATXP Plugin for Claude Code

This plugin provides seamless access to all ATXP MCP servers with simplified authentication and automatic proxy billing.

## Configuration

Set your ATXP connection string to enable authentication:

```zsh
echo 'export ATXP_CONNECTION_STRING="<your-connection-string>"' >> ~/.zshrc
source ~/.zshrc
```

Get your connection string from your [ATXP dashboard](https://atxp.ai).

## Installation

Install this plugin from the ATXP marketplace:

```bash
/plugin marketplace add atxp-dev/claude
/plugin install kitchen-sink@atxp
```

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

## How It Works

1. **Authentication**: Your connection string is stored as the `ATXP_CONNECTION_STRING` environment variable
2. **Proxy Mode**: All MCP servers automatically use the ATXP MCP Proxy when the connection string is set
3. **Billing**: Usage is automatically billed to your ATXP account via the proxy - no manual payment flows needed

## Technical Details

- All MCP servers are configured as remote HTTP servers per Claude MCP docs
- Connection string is passed via the `ATXP_CONNECTION_STRING` environment variable

## Documentation

- [ATXP Documentation](https://docs.atxp.ai/atxp)
- [ATXP MCP Proxy](https://docs.atxp.ai/proxy)
- [Claude Code Plugins](https://docs.claude.com/en/docs/claude-code/plugins)

