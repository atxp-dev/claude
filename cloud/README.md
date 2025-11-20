# ATXP Cloud Plugin

Deploy your Claude Code agents to [cloud.atxp.ai](https://cloud.atxp.ai) for pay-per-use execution.

## Features

- 🚀 **One-command deployment** - Deploy your agents with `/deploy`
- 🔐 **Secure authentication** - Uses your ATXP connection string
- ⚙️ **Environment variables** - Configure secrets and API keys with 600 permissions
- 🔄 **Update existing instances** - Seamlessly update deployed agents

## Requirements

- Bash 3.2+ (default on macOS and most Linux distributions)
- Git (for deployment tracking)
- Write access to project directory

## Quick Start

### 1. Setup Authentication

First, configure your ATXP connection string:

```bash
/setup <your-connection-string>
```

Get your connection string from your [ATXP dashboard](https://atxp.ai).

### 2. Deploy Your Agent

Deploy your current directory to the cloud:

```bash
/deploy
```

This will:
- Create a zip of your project (excluding sensitive files)
- Upload to cloud.atxp.ai
- Return your instance URL
- Save the instance ID in `.atxp-instance` for future updates

### 3. Configure Environment Variables (Optional)

If your agent needs API keys or secrets:

```bash
/configure-env-var GOOGLE_ANALYTICS_API_KEY ya29.a0AfH6SMBx...
/configure-env-var DATAFORSEO_API_KEY 12345678-1234...
```

Then redeploy:

```bash
/deploy
```

## Commands

### `/setup`

Configure your ATXP connection string for authentication.

```bash
/setup <connection-string>
```

### `/deploy`

Deploy your agent to cloud.atxp.ai.

```bash
/deploy
```

**What gets deployed:**
- All project files and directories
- `.atxp/.env.production` (if configured)

**What's excluded:**
- `.env` files (except `.atxp/.env.production`)
- `node_modules/`
- `.git/`
- Credentials (`.npmrc`, `.aws/*`, `*.pem`, etc.)
- See `/deploy` command for full exclusion list

### `/configure-env-var`

Set an environment variable for your deployed agent.

```bash
/configure-env-var KEY VALUE
```

**Example:**
```bash
/configure-env-var DATABASE_URL postgresql://user:pass@host:5432/db
```

Variables are stored in `.atxp/.env.production` and included in deployments.

### `/list-env-vars`

View all configured environment variables (values masked).

```bash
/list-env-vars
```

**Example output:**
```
Environment variables in .atxp/.env.production:

  DATABASE_URL=post...****
  API_KEY=sk-1...****

(2 variables configured)
```

### `/remove-env-var`

Remove an environment variable.

```bash
/remove-env-var KEY
```

**Example:**
```bash
/remove-env-var OLD_API_KEY
```

## Environment Variables

### When to Use

Use environment variables for:
- API keys and secrets
- Database connection strings
- Third-party service credentials
- Configuration that differs between environments

### How It Works

1. Variables are stored in `.atxp/.env.production`
2. This file is **included** in deployments (unlike other `.env` files)
3. Your deployed agent can access them at runtime
4. The file is automatically added to `.gitignore` for security

### Example Workflow

```bash
# Configure multiple API keys
/configure-env-var GOOGLE_ANALYTICS_API_KEY ya29.a0AfH6SMBx...
/configure-env-var GOOGLE_SEARCH_CONSOLE_KEY AIzaSyC...
/configure-env-var DATAFORSEO_API_KEY 12345678-1234...

# Review what's configured
/list-env-vars

# Deploy with environment variables
/deploy

# Later: Update a variable
/configure-env-var DATAFORSEO_API_KEY new-key-value
/deploy

# Remove a variable
/remove-env-var GOOGLE_ANALYTICS_API_KEY
/deploy
```

### Security Best Practices

1. **Never commit secrets to git** - `.atxp/.env.production` is automatically added to `.gitignore`
2. **File permissions** - Files are created with `600` permissions (owner read/write only) to prevent access by other system users
3. **Shell history exposure** - Be aware that secrets passed via command line are stored in shell history. For highly sensitive values:
   - Manually edit `.atxp/.env.production` instead
   - Use environment variables: `/configure-env-var API_KEY "$SECRET_FROM_ENV"`
   - Clear history after use: `history -d $(history 1)`
4. **Use environment variables for all sensitive data** - Don't hardcode credentials in code
5. **Rotate keys regularly** - Use `/configure-env-var` to update keys
6. **Audit configured variables** - Use `/list-env-vars` to review (values are masked)

### Manual Management

You can also manually edit `.atxp/.env.production`:

```bash
# Edit the file directly
nano .atxp/.env.production

# Format: KEY=VALUE (one per line)
DATABASE_URL=postgresql://user:pass@host:5432/db
API_KEY=sk-1234567890
ENVIRONMENT=production
```

After manual edits, run `/deploy` to apply changes.

## Use Cases

### Pay-Per-Use Agents

Deploy agents that require external API access without managing infrastructure:

```bash
# Example: SEO analysis agent
/configure-env-var GOOGLE_ANALYTICS_API_KEY ya29...
/configure-env-var DATAFORSEO_API_KEY 1234...
/deploy
```

Users can interact with your deployed agent and pay only for usage.

### Shared Team Agents

Deploy agents for your team with shared configuration:

```bash
# Configure shared resources
/configure-env-var TEAM_DATABASE_URL postgresql://...
/configure-env-var SHARED_API_KEY sk-...
/deploy
```

### Multi-Environment Deployments

Maintain different configurations for different instances:

```bash
# Staging
/configure-env-var ENVIRONMENT staging
/configure-env-var API_KEY staging-key
/deploy  # Creates staging instance

# Production
/configure-env-var ENVIRONMENT production
/configure-env-var API_KEY prod-key
/deploy  # Updates or creates production instance
```

## Instance Management

### Instance Tracking

Your instance ID is stored in `.atxp-instance` after the first deployment:

```bash
cat .atxp-instance
# Output: abc123def456
```

This file is used to update existing deployments. Don't commit it to git (it's in `.gitignore`).

### Updating Deployments

Simply run `/deploy` again:

```bash
# Make changes to your agent
vim my-agent.js

# Deploy updates
/deploy
```

The existing instance will be updated using the ID from `.atxp-instance`.

### Creating New Instances

To create a new instance instead of updating:

```bash
# Remove the instance tracking file
rm .atxp-instance

# Deploy creates a new instance
/deploy
```

## Troubleshooting

### "Connection token not found"

Run `/setup` with your connection string:

```bash
/setup <your-connection-string>
```

### "Instance not found"

Your `.atxp-instance` file may reference a deleted instance:

```bash
rm .atxp-instance
/deploy  # Creates new instance
```

### "Forbidden: You don't own this instance"

The instance ID in `.atxp-instance` belongs to another account. Remove it:

```bash
rm .atxp-instance
/deploy
```

### Environment variables not working

1. Verify they're configured:
   ```bash
   /list-env-vars
   ```

2. Check the file exists:
   ```bash
   cat .atxp/.env.production
   ```

3. Redeploy to apply changes:
   ```bash
   /deploy
   ```

## Documentation

- [cloud.atxp.ai](https://cloud.atxp.ai) - Cloud deployment platform
- [ATXP Dashboard](https://atxp.ai) - Get your connection string
- [ATXP Documentation](https://docs.atxp.ai) - Full ATXP docs

## Support

For issues or questions:
- ATXP Documentation: https://docs.atxp.ai
- ATXP Support: https://atxp.ai/support

## License

MIT License - see [LICENSE](../LICENSE) for details.
