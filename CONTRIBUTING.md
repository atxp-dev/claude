# Contributing to ATXP Plugin Marketplace

Thank you for your interest in contributing to the ATXP plugin marketplace!

## Repository Structure

```
.
├── .claude-plugin/
│   └── marketplace.json          # Marketplace manifest
├── atxp-plugin/                  # Main ATXP plugin
│   ├── .claude-plugin/
│   │   └── plugin.json           # Plugin manifest
│   ├── commands/
│   │   └── atxp-auth.md          # Authentication command
│   ├── .mcp.json                 # MCP server configurations
│   └── README.md                 # Plugin documentation
├── README.md                     # Main documentation
├── LICENSE                       # MIT License
└── CONTRIBUTING.md               # This file
```

## How to Contribute

### Adding New MCP Servers

If ATXP releases new MCP servers, add them to `atxp-plugin/.mcp.json`:

```json
{
  "mcpServers": {
    "atxp-new-server": {
      "command": "npx",
      "args": ["-y", "@atxp/mcp-new-server@latest"],
      "env": {
        "ATXP_CONNECTION_STRING": "${ATXP_CONNECTION_STRING:-}",
        "ATXP_PROXY_ENABLED": "true"
      }
    }
  }
}
```

Don't forget to update the README files to document the new server.

### Adding New Commands

To add new slash commands:

1. Create a new markdown file in `atxp-plugin/commands/`
2. Follow the format of existing commands
3. Update documentation

### Testing Your Changes

To test the plugin locally:

1. Start Claude Code from the parent directory of this repository
2. Add the local marketplace:
   ```bash
   /plugin marketplace add ./path/to/this/repo
   ```
3. Install the plugin:
   ```bash
   /plugin install atxp@atxp-claude
   ```
4. Test your changes

### Submitting Changes

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Make your changes
4. Test thoroughly
5. Commit your changes (`git commit -m 'Add some feature'`)
6. Push to the branch (`git push origin feature/your-feature`)
7. Open a Pull Request

## Code Style

- Use 2 spaces for indentation in JSON files
- Keep markdown files well-formatted and easy to read
- Follow the existing patterns in the codebase

## Questions?

If you have questions or need help, please:
- Check the [Claude Code plugin documentation](https://docs.claude.com/en/docs/claude-code/plugins)
- Review the [ATXP documentation](https://docs.atxp.ai/atxp)
- Open an issue in this repository

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

