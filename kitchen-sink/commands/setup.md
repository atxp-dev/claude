---
name: setup
description: Interpolate a connection string into MCP server template and merge into project .mcp.json
arguments:
  - name: connection_string
    description: ATXP connection string, e.g. https://accounts.atxp.ai?...
    required: true
run:
  type: command
  command: ${CLAUDE_PLUGIN_ROOT}/scripts/setup-mcp.js
  args:
    - --connection
    - "${args.connection}"
---

Run the setup to configure ATXP MCP servers in the current project root.

Usage:

```
/setup <connection_string>
```

This will:

- Read `kitchen-sink/mcp.template.json`
- Replace `${CONNECTION_STRING}` with the provided connection string
- Merge the resulting `mcpServers` into the current workspace `.mcp.json` if it exists, otherwise create it

After running, the project's `.mcp.json` will contain the ATXP MCP servers.

