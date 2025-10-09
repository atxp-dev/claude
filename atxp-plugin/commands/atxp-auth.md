---
description: Set your ATXP connection string for seamless access to ATXP MCP servers
---

# ATXP Authentication

This command sets your ATXP connection string, which enables:
- Automatic authentication with all ATXP MCP servers
- Use of the ATXP MCP Proxy for simplified billing
- No manual payment flows when using ATXP tools

## Usage

When the user provides their ATXP connection string, store it by setting the `ATXP_CONNECTION_STRING` environment variable. This will be automatically used by all ATXP MCP servers.

Respond with a confirmation message like:
"✓ ATXP connection string configured successfully! You can now use all ATXP MCP servers through the proxy."

If no connection string is provided, explain:
"Please provide your ATXP connection string. You can find this in your ATXP dashboard at https://atxp.ai

Usage: /atxp-auth <your-connection-string>

The connection string enables automatic authentication and billing through the ATXP MCP Proxy."

## Important Notes

- The connection string is stored as an environment variable for the current session
- All ATXP MCP servers will automatically use the proxy when this is set
- Visit https://docs.atxp.ai/proxy for more information about the proxy functionality

