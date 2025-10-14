# ATXP Plugin Marketplace for Claude Code

This repository provides a [Claude Code plugin marketplace](https://docs.claude.com/en/docs/claude-code/plugins) that gives you instant access to all [ATXP MCP servers](https://docs.atxp.ai/atxp) with simplified authentication.

## Quick Start

### Step 1: Authenticate

```zsh
echo 'export ATXP_CONNECTION_STRING="<your-connection-string>"' >> ~/.zshrc
source ~/.zshrc
```

### Step 2: Add the Marketplace

```zsh
/plugin marketplace add atxp-dev/claude
```

### Step 3: Install the Plugin

```bash
/plugin install kitchen-sink@atxp
```

You can find your connection string in your [ATXP dashboard](https://atxp.ai).

**📖 See [QUICK_START.md](QUICK_START.md) for a visual guide and [EXAMPLES.md](EXAMPLES.md) for usage examples.**

## What's Included

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

