---
name: remove-env-var
description: Remove an environment variable
---

Removes an environment variable from `.atxp/.env.production`.

## Usage

```bash
/remove-env-var KEY
```

Replace `KEY` with the name of the environment variable you want to remove.

## Examples

Remove a single variable:

```bash
/remove-env-var GOOGLE_ANALYTICS_API_KEY
```

Remove multiple variables:

```bash
/remove-env-var DATAFORSEO_API_KEY
/remove-env-var OLD_API_KEY
```

## Implementation

```bash
#!/bin/bash

# Parse arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: /remove-env-var KEY"
    echo "Example: /remove-env-var API_KEY"
    exit 1
fi

KEY="$1"

ENV_FILE=".atxp/.env.production"

if [ ! -f "$ENV_FILE" ]; then
    echo "No environment variables file found at ${ENV_FILE}"
    echo ""
    echo "Nothing to remove."
    exit 0
fi

# Check if the key exists
if ! grep -q "^${KEY}=" "$ENV_FILE"; then
    echo "Environment variable ${KEY} not found in ${ENV_FILE}"
    echo ""
    echo "To see all configured variables, use:"
    echo "  /list-env-vars"
    exit 1
fi

# Create a temporary file and filter out the key
TEMP_FILE=$(mktemp) || {
    echo "Error: Failed to create temporary file"
    exit 1
}
grep -v "^${KEY}=" "$ENV_FILE" > "$TEMP_FILE" || true

# Replace the original file
mv "$TEMP_FILE" "$ENV_FILE"

echo "✓ Removed ${KEY} from ${ENV_FILE}"

# Check if file is now empty
if [ ! -s "$ENV_FILE" ]; then
    echo ""
    echo "The environment variables file is now empty."
    rm "$ENV_FILE"
    echo "✓ Removed empty ${ENV_FILE}"
fi

echo ""
echo "Next steps:"
echo "  1. Review remaining variables: /list-env-vars"
echo "  2. Deploy your agent: /deploy"
```

## How it works

1. Searches for the environment variable in `.atxp/.env.production`
2. Removes the line containing that variable
3. If the file becomes empty after removal, deletes the file
4. Changes take effect on the next `/deploy`

## Notes

- The variable name is case-sensitive
- To see all configured variables before removing, use `/list-env-vars`
- If you remove all variables, the `.atxp/.env.production` file will be deleted
- Changes only take effect after running `/deploy`
- You can also manually edit `.atxp/.env.production` if needed

## Example Workflow

```bash
# List current variables
/list-env-vars
# Output:
#   GOOGLE_ANALYTICS_API_KEY=ya29...****
#   OLD_API_KEY=test...****
#   (2 variables configured)

# Remove the old key
/remove-env-var OLD_API_KEY
# Output: ✓ Removed OLD_API_KEY from .atxp/.env.production

# Verify removal
/list-env-vars
# Output:
#   GOOGLE_ANALYTICS_API_KEY=ya29...****
#   (1 variable configured)

# Deploy with updated variables
/deploy
```

## Related Commands

- `/configure-env-var` - Add or update an environment variable
- `/list-env-vars` - List all configured environment variables
- `/deploy` - Deploy your agent with environment variables
