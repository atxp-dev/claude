# 🚀 ATXP Plugin - Quick Start Guide

Get up and running with ATXP in Claude Code in 3 simple steps!

## Installation

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

🎉 **You're done!** All ATXP MCP servers are now available.

---

## What You Get

| MCP Server | What It Does | Example Use |
|------------|--------------|-------------|
| **atxp-browse** | Browser automation | "Navigate to this site and..." |
| **atxp-crawl** | Web crawling | "Extract text from these pages..." |
| **atxp-search** | Web search | "Search for the latest..." |
| **atxp-research** | Topic research | "Research this topic with sources..." |
| **atxp-database** | PostgreSQL | "Create a table and insert rows..." |
| **atxp-filestore** | Files | "Store this file and return a URL..." |
| **atxp-image** | Image generation | "Generate an image of..." |
| **atxp-music** | Music generation | "Compose a song in this style..." |
| **atxp-video** | Video generation | "Create a short video about..." |
| **atxp-code** | Code execution | "Run this Python snippet..." |
| **atxp-x-live-search** | X search | "Find posts by @handle this month..." |

---

## Your First Commands

### Generate an Image
```
Generate an image of a sunset over mountains
```

### Search the Web
```
Search for the latest AI news
```

### Analyze Text
```
Analyze the sentiment of: "I love this product!"
```

### Scrape a Website
```
Visit example.com and tell me the page title
```

---

## Getting Your Connection String

1. Visit [atxp.ai](https://atxp.ai)
2. Log in to your dashboard
3. Find your connection string in the API settings
4. Copy and use with `/atxp-auth`

---

## Need Help?

- 📖 [Full Documentation](README.md)
- 💡 [Usage Examples](EXAMPLES.md)
- 🔧 [Contributing Guide](CONTRIBUTING.md)
- 📝 [Changelog](CHANGELOG.md)

---

## Benefits

✅ **One-command installation** - No complex setup  
✅ **Automatic authentication** - Set once, use everywhere  
✅ **Auto-billing via proxy** - No manual payment flows  
✅ **All ATXP tools** - Everything in one plugin  
✅ **HTTP servers** - Configured per Claude MCP docs  

---

**Questions?** Check out the [ATXP Documentation](https://docs.atxp.ai/atxp) or [Claude Code Plugins Guide](https://docs.claude.com/en/docs/claude-code/plugins).

