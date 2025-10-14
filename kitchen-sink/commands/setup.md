---
name: setup
description: Interpolate a connection string into MCP server template and merge into project .mcp.json
---

Run the setup to configure ATXP MCP servers in the current project root.

Usage:

```
/setup <connection_string>
```

This should result in running:

```bash
"$CLAUDE_PLUGIN_ROOT/scripts/setup-mcp.js" --connection <connection string>
```

That script will:

- Read `kitchen-sink/mcp.template.json`
- Replace `${CONNECTION_STRING}` with the provided connection string
- Merge the resulting `mcpServers` into the current workspace `.mcp.json` if it exists, otherwise create it

After running, the project's `.mcp.json` will contain the ATXP MCP servers.

