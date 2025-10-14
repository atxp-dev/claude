---
name: setup
description: Interpolate a connection string into MCP server template and merge into project .mcp.json
---

Run the setup to configure ATXP MCP servers in the current project root.

Usage:

```
/setup <connection_string>
```

This should result in taking the following JSON, replacing `${CONNECTION_STRING}` with the provided connection string, and then merging it into the current project's `.mcp.json` if it exists, or creating it if it does not.

```json
{
  "mcpServers": {
    "atxp-browse": {
      "type": "http",
      "url": "${CONNECTION_STRING}&server=browse.mcp.atxp.ai"
    },
    "atxp-crawl": {
      "type": "http",
      "url": "${CONNECTION_STRING}&server=crawl.mcp.atxp.ai"
    },
    "atxp-search": {
      "type": "http",
      "url": "${CONNECTION_STRING}&server=search.mcp.atxp.ai"
    },
    "atxp-research": {
      "type": "http",
      "url": "${CONNECTION_STRING}&server=research.mcp.atxp.ai"
    },
    "atxp-database": {
      "type": "http",
      "url": "${CONNECTION_STRING}&server=database.mcp.atxp.ai"
    },
    "atxp-filestore": {
      "type": "http",
      "url": "${CONNECTION_STRING}&server=filestore.mcp.atxp.ai"
    },
    "atxp-image": {
      "type": "http",
      "url": "${CONNECTION_STRING}&server=image.mcp.atxp.ai"
    },
    "atxp-music": {
      "type": "http",
      "url": "${CONNECTION_STRING}&server=music.mcp.atxp.ai"
    },
    "atxp-video": {
      "type": "http",
      "url": "${CONNECTION_STRING}&server=video.mcp.atxp.ai"
    },
    "atxp-code": {
      "type": "http",
      "url": "${CONNECTION_STRING}&server=code.mcp.atxp.ai"
    },
    "atxp-x-live-search": {
      "type": "http",
      "url": "${CONNECTION_STRING}&server=x-live-search.mcp.atxp.ai"
    }
  }
}
```

After running this command, the project's `.mcp.json` will contain the ATXP MCP servers.

Please let the user know that they will need to restart Claude Code for the changes to take effect.