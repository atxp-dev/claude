# Changelog

All notable changes to the ATXP Plugin Marketplace will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-10-09

### Added

- Initial release of ATXP plugin marketplace
- Main ATXP plugin with all MCP servers bundled
- `/atxp-auth` command for setting connection string
- Support for ATXP MCP Proxy functionality
- Automatic authentication via environment variables
- Pre-configured MCP servers:
  - atxp-fetch (Web scraping and HTTP)
  - atxp-image (Image generation)
  - atxp-memory (Persistent storage)
  - atxp-browse (Browser automation)
  - atxp-search (Web search)
  - atxp-text (Text processing)
  - atxp-vision (Computer vision)
- Comprehensive documentation and examples
- MIT License

### Features

- One-command installation via Claude Code
- Simplified authentication flow
- Automatic proxy billing
- Zero-configuration setup for all ATXP services

[1.0.0]: https://github.com/atxp-dev/claude/releases/tag/v1.0.0


## [1.1.0] - 2025-10-10

### Changed

- Switched to official ATXP HTTP MCP servers and aligned documentation
- Renamed `atxp-puppeteer` to `atxp-browse` to match official naming
- Updated repository references from `atxp/claude` to `atxp-dev/claude`
- Updated `EXAMPLES.md` to reflect available MCP servers:
  - Removed: `atxp-text`, `atxp-vision`, `atxp-memory`
  - Added examples for: `atxp-research`, `atxp-database`, `atxp-filestore`, `atxp-music`, `atxp-video`, `atxp-code`, `atxp-x-live-search`
  - Adjusted combined workflows to use filestore instead of memory

### Documentation

- Clarified that all MCP servers are remote HTTP servers using the ATXP MCP Proxy
- Linked to relevant docs for proxy and marketplace usage

### Notes

- No breaking API changes; users should run `/plugin update atxp@atxp-claude`

