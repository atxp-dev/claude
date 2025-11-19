---
name: configure-env-var
description: Set an environment variable for your deployed agent
---

Sets an environment variable by writing it to `.atxp/.env.production`, which is included in deployments to cloud.atxp.ai.

## Usage

```bash
/configure-env-var KEY VALUE
```

Replace `KEY` with your environment variable name and `VALUE` with its value.

## Examples

Set API keys for external services:

```bash
/configure-env-var GOOGLE_ANALYTICS_API_KEY ya29.a0AfH6SMBx...
/configure-env-var GOOGLE_SEARCH_CONSOLE_KEY AIzaSyC...
/configure-env-var DATAFORSEO_API_KEY 12345678-1234-1234-1234-123456789abc
```

## How it works

1. Creates `.atxp/.env.production` if it doesn't exist
2. Adds or updates the environment variable in `KEY=VALUE` format
3. The file will be included in your next `/deploy`
4. Your deployed agent can access these variables at runtime

## Implementation

```bash
#!/bin/bash

# Parse arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: /configure-env-var KEY VALUE"
    echo "Example: /configure-env-var API_KEY abc123"
    exit 1
fi

KEY="$1"
shift
VALUE="$*"

# Validate key format (alphanumeric and underscore only)
if ! echo "$KEY" | grep -qE '^[A-Za-z_][A-Za-z0-9_]*$'; then
    echo "Error: KEY must start with a letter or underscore and contain only alphanumeric characters and underscores"
    exit 1
fi

# Create .atxp directory if it doesn't exist
mkdir -p .atxp

ENV_FILE=".atxp/.env.production"

# Create or update the env file
if [ -f "$ENV_FILE" ]; then
    # File exists, check if key already exists
    if grep -q "^${KEY}=" "$ENV_FILE"; then
        # Update existing key
        # Use a temporary file for safety
        TEMP_FILE=$(mktemp)
        while IFS= read -r line; do
            if echo "$line" | grep -q "^${KEY}="; then
                echo "${KEY}=${VALUE}"
            else
                echo "$line"
            fi
        done < "$ENV_FILE" > "$TEMP_FILE"
        mv "$TEMP_FILE" "$ENV_FILE"
        echo "✓ Updated ${KEY} in ${ENV_FILE}"
    else
        # Append new key
        echo "${KEY}=${VALUE}" >> "$ENV_FILE"
        echo "✓ Added ${KEY} to ${ENV_FILE}"
    fi
else
    # Create new file
    echo "${KEY}=${VALUE}" > "$ENV_FILE"
    echo "✓ Created ${ENV_FILE} with ${KEY}"
fi

# Check if .gitignore exists and contains the env file
GITIGNORE_WARNED=false
if [ -f ".gitignore" ]; then
    if ! grep -qF ".atxp/.env.production" .gitignore; then
        GITIGNORE_WARNED=true
    fi
else
    GITIGNORE_WARNED=true
fi

if [ "$GITIGNORE_WARNED" = true ]; then
    echo ""
    echo "⚠️  SECURITY WARNING: Add .atxp/.env.production to your .gitignore"
    echo "   Run: echo '.atxp/.env.production' >> .gitignore"
fi

echo ""
echo "Next steps:"
echo "  1. Review variables: /list-env-vars"
echo "  2. Deploy your agent: /deploy"
```

## Security Considerations

⚠️ **Important:** The `.atxp/.env.production` file contains sensitive credentials and should never be committed to version control.

After using this command for the first time, add it to your `.gitignore`:

```bash
echo '.atxp/.env.production' >> .gitignore
```

The command will warn you if this entry is missing.

## File Format

Variables are stored in standard `.env` format:

```
KEY1=value1
KEY2=value2
KEY3=value with spaces
```

## Notes

- To update an existing variable, simply run the command again with the new value
- To view all configured variables, use `/list-env-vars`
- To remove a variable, use `/remove-env-var KEY`
- You can also manually edit `.atxp/.env.production` if needed
- Changes take effect on the next `/deploy`

## Related Commands

- `/list-env-vars` - List all configured environment variables
- `/remove-env-var` - Remove an environment variable
- `/deploy` - Deploy your agent with environment variables
