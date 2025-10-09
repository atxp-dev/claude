# ATXP Plugin Usage Examples

This document provides practical examples of using the ATXP plugin in Claude Code.

## Initial Setup

```bash
# Add the marketplace
/plugin marketplace add atxp-dev/claude

# Install the ATXP plugin
/plugin install atxp@atxp-claude

# Set your connection string
/atxp-auth your-connection-string-here
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

## Text Processing Examples

### Analysis

```
Analyze the sentiment and key themes in this text: [your text here]
```

Uses the `atxp-text` server for advanced text processing.

### Summarization

```
Summarize this article into 3 key bullet points: [article text]
```

## Vision Examples

### Image Analysis

```
Analyze this image and describe what you see: [provide image]
```

Uses the `atxp-vision` server for computer vision tasks.

### OCR

```
Extract all text from this screenshot: [provide image]
```

## Memory Examples

### Store Information

```
Remember that my API key for service X is ABC123
```

Uses `atxp-memory` to store information persistently.

### Retrieve Information

```
What was my API key for service X?
```

## Fetch Examples

### API Requests

```
Fetch the current weather data from https://api.weather.com/current
```

Uses `atxp-fetch` for HTTP requests.

### Web Scraping

```
Scrape the latest headlines from https://news.example.com
```

## Combined Workflows

### Content Creation Pipeline

```
1. Search for trending topics in tech
2. Generate an image related to the top topic
3. Write a blog post about it
4. Save the draft to memory
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

If you get authentication errors:

```bash
# Re-authenticate
/atxp-auth your-connection-string-here
```

Then restart Claude Code.

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

