# Repository Structure

This document explains the structure of the ATXP plugin marketplace repository.

## Directory Layout

```
atxp/claude/
│
├── .claude-plugin/
│   └── marketplace.json          # Marketplace manifest - defines the marketplace
│
├── atxp-plugin/                  # Main ATXP plugin
│   ├── .claude-plugin/
│   │   └── plugin.json           # Plugin manifest - defines plugin metadata
│   │
│   ├── commands/
│   │   └── atxp-auth.md          # /atxp-auth command implementation
│   │
│   ├── .mcp.json                 # MCP server configurations for all ATXP servers
│   └── README.md                 # Plugin-specific documentation
│
├── README.md                     # Main documentation
├── QUICK_START.md                # Quick reference guide
├── EXAMPLES.md                   # Usage examples for each MCP server
├── CONTRIBUTING.md               # Contribution guidelines
├── CHANGELOG.md                  # Version history
├── STRUCTURE.md                  # This file
├── LICENSE                       # MIT License
└── .gitignore                    # Git ignore rules
```

## Key Files Explained

### Marketplace Files

#### `.claude-plugin/marketplace.json`
Defines the marketplace itself. This is what Claude Code reads when users run:
```bash
/plugin marketplace add atxp/claude
```

Contains:
- Marketplace name and owner
- List of available plugins (currently just "atxp")
- Plugin sources and descriptions

### Plugin Files

#### `atxp-plugin/.claude-plugin/plugin.json`
Defines the ATXP plugin metadata:
- Plugin name, description, version
- Author information

#### `atxp-plugin/commands/atxp-auth.md`
Implements the `/atxp-auth` command:
- Stores ATXP connection string as environment variable
- Provides user instructions
- Explains proxy functionality

#### `atxp-plugin/.mcp.json`
Configures all ATXP MCP servers:
- `atxp-fetch` - Web scraping and HTTP
- `atxp-image` - Image generation
- `atxp-memory` - Persistent storage
- `atxp-puppeteer` - Browser automation
- `atxp-search` - Web search
- `atxp-text` - Text processing
- `atxp-vision` - Computer vision

Each server is configured to:
- Run via `npx` with latest version
- Use the `ATXP_CONNECTION_STRING` environment variable
- Enable proxy mode automatically

### Documentation Files

#### `README.md`
Main entry point with:
- Installation instructions
- Feature overview
- Quick examples
- Links to other docs

#### `QUICK_START.md`
Visual quick reference:
- Installation steps
- Table of available servers
- First commands to try
- Benefits summary

#### `EXAMPLES.md`
Comprehensive usage examples:
- Examples for each MCP server
- Combined workflows
- Troubleshooting tips

#### `CONTRIBUTING.md`
For contributors:
- How to add new MCP servers
- How to add new commands
- Testing procedures
- Submission guidelines

#### `CHANGELOG.md`
Version history:
- Release dates
- New features
- Changes and fixes

## How It Works

### Installation Flow

1. **User adds marketplace**: `/plugin marketplace add atxp/claude`
   - Claude Code reads `.claude-plugin/marketplace.json`
   - Marketplace is added to available sources

2. **User installs plugin**: `/plugin install atxp@atxp-claude`
   - Claude Code reads `atxp-plugin/.claude-plugin/plugin.json`
   - Installs MCP servers from `atxp-plugin/.mcp.json`
   - Makes commands from `atxp-plugin/commands/` available

3. **User authenticates**: `/atxp-auth <connection-string>`
   - Command from `atxp-auth.md` runs
   - Sets `ATXP_CONNECTION_STRING` environment variable
   - All MCP servers can now authenticate via proxy

### Usage Flow

1. **User makes a request**: "Generate an image of a sunset"
2. **Claude Code identifies tool**: Recognizes this needs `atxp-image`
3. **Tool executes**: 
   - `npx @atxp/mcp-image@latest` runs
   - Uses `ATXP_CONNECTION_STRING` from environment
   - Connects via ATXP proxy
   - Billing handled automatically
4. **Result returned**: Image is generated and shown to user

## Extending the Plugin

### Adding a New MCP Server

1. Edit `atxp-plugin/.mcp.json`
2. Add new server configuration following the existing pattern
3. Update `README.md` and `EXAMPLES.md`
4. Increment version in `plugin.json`
5. Update `CHANGELOG.md`

### Adding a New Command

1. Create new markdown file in `atxp-plugin/commands/`
2. Follow the format of `atxp-auth.md`
3. Update documentation
4. Test locally before committing

### Publishing Updates

1. Update version numbers
2. Update `CHANGELOG.md`
3. Commit and push changes
4. Users run `/plugin update atxp@atxp-claude` to get the latest

## Technical Details

### Environment Variables

- `ATXP_CONNECTION_STRING`: User's ATXP connection string for authentication
- `ATXP_PROXY_ENABLED`: Set to `"true"` to enable proxy mode for all servers

### Package Management

All MCP servers use `npx` with:
- `-y` flag for automatic installation
- `@latest` to always get the newest version
- `@atxp/` package scope for ATXP's official packages

### Proxy Mode

When `ATXP_CONNECTION_STRING` is set:
1. MCP servers detect the environment variable
2. Connect to ATXP via proxy instead of direct API
3. Proxy handles authentication and billing
4. Users don't see payment prompts

## Security Considerations

- Connection strings are stored as environment variables (session-only)
- MCP servers run in isolated processes via `npx`
- All communication with ATXP uses secure HTTPS
- No credentials are stored in files or version control

## Performance

- MCP servers are lazy-loaded (only when needed)
- `npx` caches packages after first use
- Proxy adds minimal latency (~50-100ms)
- Servers run in parallel when possible

## Support

For issues with:
- **Structure or organization**: See [CONTRIBUTING.md](CONTRIBUTING.md)
- **Using the plugin**: See [EXAMPLES.md](EXAMPLES.md)
- **ATXP services**: See [ATXP Documentation](https://docs.atxp.ai/atxp)
- **Claude Code**: See [Claude Code Docs](https://docs.claude.com/en/docs/claude-code/plugins)

