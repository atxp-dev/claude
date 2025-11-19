# ATXP Plugin Marketplace for Claude Code

This repository provides a [Claude Code plugin marketplace](https://docs.claude.com/en/docs/claude-code/plugins) that gives you instant access to all [ATXP MCP servers](https://docs.atxp.ai/atxp) with simplified authentication.

## Quick Start

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

You can find your connection string in your [ATXP dashboard](https://atxp.ai).

**📖 See [QUICK_START.md](QUICK_START.md) for a visual guide and [EXAMPLES.md](EXAMPLES.md) for usage examples.**

## What's Included

This marketplace includes two plugins:

### Kitchen Sink Plugin

The ATXP plugin bundles official ATXP MCP servers:

- **atxp-browse** - Browser automation and capture
- **atxp-crawl** - Crawl and extract page content at scale
- **atxp-search** - Web search with structured results
- **atxp-research** - Topic research with sources and citations
- **atxp-database** - PostgreSQL management and SQL execution
- **atxp-filestore** - Store and retrieve files
- **atxp-image** - Image generation
- **atxp-music** - Music generation
- **atxp-video** - Video generation
- **atxp-code** - Execute code in a sandbox
- **atxp-x-live-search** - Search X (Twitter) with filters

### Cloud Plugin

Deploy your Claude Code agents to [cloud.atxp.ai](https://cloud.atxp.ai) with environment variable support:

- **`/deploy`** - Deploy agents to the cloud for pay-per-use execution
- **`/configure-env-var`** - Set environment variables (API keys, secrets)
- **`/list-env-vars`** - View configured environment variables
- **`/remove-env-var`** - Remove environment variables

See the [Cloud Plugin README](cloud/README.md) for detailed documentation.

## Features

### 💰 Automatic Billing via Proxy

When you set your connection string, all ATXP MCP servers automatically use the [ATXP MCP Proxy](https://docs.atxp.ai/proxy), eliminating manual payment flows. Usage is billed directly to your ATXP account.

### 🚀 Zero Configuration

All MCP servers are configured as remote HTTP servers per Claude MCP spec and ready to use. Set your auth and start building!

## Example Usage

After installation and authentication, you can use any ATXP tool naturally in Claude Code:

```
Generate an image of a sunset over mountains
```

Claude Code will automatically use the `atxp-image` MCP server (HTTP) to generate your image.

```
Search the web for the latest news about AI
```

Claude Code will use the `atxp-search` MCP server to find relevant results.

## Documentation

### This Repository
- [Quick Start Guide](QUICK_START.md) - Visual quick reference
- [Usage Examples](EXAMPLES.md) - Practical examples for each MCP server
- [Repository Structure](STRUCTURE.md) - Detailed explanation of how everything works
- [Contributing](CONTRIBUTING.md) - How to contribute
- [Changelog](CHANGELOG.md) - Version history

### External Links
- [ATXP Documentation](https://docs.atxp.ai/atxp)
- [ATXP MCP Proxy](https://docs.atxp.ai/proxy)
- [Claude Code Plugins](https://docs.claude.com/en/docs/claude-code/plugins)
- [Plugin Marketplaces](https://docs.claude.com/en/docs/claude-code/plugin-marketplaces)

## Support

For issues or questions:
- ATXP Documentation: https://docs.atxp.ai
- ATXP Support: https://atxp.ai/support

## License

MIT License - see [LICENSE](LICENSE) for details.

