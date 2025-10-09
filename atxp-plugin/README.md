# ATXP Plugin for Claude Code

This plugin provides seamless access to all ATXP MCP servers with simplified authentication and automatic proxy billing.

## Installation

Install this plugin from the ATXP marketplace:

```bash
/plugin marketplace add atxp/claude
/plugin install atxp@atxp-claude
```

## Configuration

Set your ATXP connection string to enable authentication:

```bash
/atxp-auth <your-connection-string>
```

Get your connection string from your [ATXP dashboard](https://atxp.ai).

## Available MCP Servers

This plugin includes the following ATXP MCP servers:

### atxp-fetch
Web scraping and HTTP request capabilities.

### atxp-image
Generate and manipulate images using AI.

### atxp-memory
Persistent memory and storage for your applications.

### atxp-puppeteer
Browser automation for testing and scraping.

### atxp-search
Web search capabilities powered by ATXP.

### atxp-text
Advanced text processing and analysis.

### atxp-vision
Computer vision and image analysis tools.

## How It Works

1. **Authentication**: Your connection string is stored as the `ATXP_CONNECTION_STRING` environment variable
2. **Proxy Mode**: All MCP servers automatically use the ATXP MCP Proxy when the connection string is set
3. **Billing**: Usage is automatically billed to your ATXP account via the proxy - no manual payment flows needed

## Technical Details

- All MCP servers are installed via `npx` with the `@atxp/` package scope
- The `ATXP_PROXY_ENABLED` environment variable is set to `true` for all servers
- Connection string is passed via the `ATXP_CONNECTION_STRING` environment variable

## Documentation

- [ATXP Documentation](https://docs.atxp.ai/atxp)
- [ATXP MCP Proxy](https://docs.atxp.ai/proxy)
- [Claude Code Plugins](https://docs.claude.com/en/docs/claude-code/plugins)

