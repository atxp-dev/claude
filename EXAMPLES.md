# ATXP Plugin Usage Examples

This document provides practical examples of using the ATXP plugin in Claude Code.

## Initial Setup

```zsh
echo 'export ATXP_CONNECTION_STRING="<your-connection-string>"' >> ~/.zshrc
source ~/.zshrc

# Add the marketplace
/plugin marketplace add atxp-dev/claude

# Install the ATXP plugin
/plugin install kitchen-sink@atxp
```

## Image Generation Examples

### Generate a Simple Image

```
Generate an image of a mountain landscape at sunset
```

Claude Code will automatically use the `atxp-image` MCP server to create the image.

### Generate with Specific Requirements

```
Create a 1920x1080 image of a futuristic city with neon lights and flying cars
```

### Multiple Images

```
Generate three variations of a logo design: 
1. Modern and minimalist
2. Bold and colorful  
3. Classic and elegant
```

## Web Search Examples

### Current Information

```
Search for the latest developments in quantum computing
```

Claude Code will use `atxp-search` to find up-to-date information.

### Research

```
Find academic papers about machine learning interpretability from the last year
```

## Research Examples

### Topic Deep-Dive

```
Research the implications of CRISPR gene editing and provide 5 reputable sources
```

Claude Code will use `atxp-research` to synthesize an answer with citations.

### Comparative Overview

```
Compare Rust vs Go for backend services. Include trade-offs and sources.
```

## Browser Automation Examples

### Web Scraping

```
Use the browser to visit example.com and extract all the heading text
```

The `atxp-browse` server will handle the browser automation.

### Testing

```
Navigate to my website at https://mysite.com and take a screenshot
```

## Database Examples

### Create a Database

```
Create a Postgres database named analytics
```

### Run SQL

```
Run SQL: SELECT COUNT(*) FROM events WHERE type = 'signup';
```

Uses `atxp-database` for Postgres management and queries.

## Filestore Examples

### Save a File

```
Save this text as report.txt: [paste content]
```

### Retrieve a File

```
Retrieve report.txt and show its contents
```

Uses `atxp-filestore` to store and retrieve files.

## Music Generation Examples

### Compose Music

```
Compose a 30-second lo-fi hip-hop beat at 90 BPM with vinyl crackle
```

Uses `atxp-music` to generate audio.

## Video Generation Examples

### Create a Short Video

```
Create a 5-second looping video of a neon city at night in cyberpunk style
```

Uses `atxp-video` to generate video.

## Code Execution Examples

### Run Code

```
Execute Python to parse this JSON and return the name field: {"name":"Ada","id":1}
```

Uses `atxp-code` to run sandboxed code.

## X Live Search Examples

### Search X (Twitter)

```
Search X for posts about "TypeScript 5.7" from the last week with at least 100 likes
```

Uses `atxp-x-live-search` to query X with filters.

## Crawl Examples

### Crawl a Single Page

```
Crawl https://example.com and extract the main article text
```

### Crawl Multiple Pages

```
Crawl https://docs.example.com starting at /guide with a limit of 5 pages and return titles and URLs
```

## Combined Workflows

### Content Creation Pipeline

```
1. Search for trending topics in tech
2. Generate an image related to the top topic
3. Write a blog post about it
4. Save the draft to filestore
```

### Research and Analysis

```
1. Fetch data from https://api.example.com/data
2. Analyze the data for patterns
3. Generate visualizations
4. Create a summary report
```

### Automated Testing

```
1. Use the browser to navigate to my app
2. Take screenshots of each page
3. Analyze the screenshots for broken layouts
4. Generate a test report
```

## Tips

- **Be specific**: The more details you provide, the better the results
- **Chain operations**: Claude Code can combine multiple ATXP tools in sequence
- **Check your quota**: Monitor your ATXP dashboard for usage and billing
- **Restart if needed**: If you update your connection string, restart Claude Code to apply changes

## Troubleshooting

### Connection Issues

If you get authentication errors, make sure that you've defined `ATXP_CONNECTION_STRING` in your shell.

### Server Not Found

If a specific MCP server isn't working:

1. Check that the plugin is installed: `/plugin`
2. Verify your connection string is set
3. Check the ATXP status page for service availability

### Usage Limits

If you hit usage limits:

1. Check your ATXP dashboard for current usage
2. Upgrade your plan if needed
3. Wait for quota reset (if on a limited plan)

## Need More Help?

- [ATXP Documentation](https://docs.atxp.ai/atxp)
- [Claude Code Plugin Docs](https://docs.claude.com/en/docs/claude-code/plugins)
- [ATXP Support](https://atxp.ai/support)

