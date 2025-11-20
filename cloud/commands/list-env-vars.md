---
name: list-env-vars
description: List configured environment variables
---

Lists all environment variables configured in `.atxp/.env.production` with their values masked for security.

## Usage

```bash
/list-env-vars
```

## Example Output

```
Environment variables in .atxp/.env.production:

  GOOGLE_ANALYTICS_API_KEY=ya29...****
  GOOGLE_SEARCH_CONSOLE_KEY=AIza...****
  DATAFORSEO_API_KEY=1234...****

(3 variables configured)
```

## Implementation

```bash
#!/bin/bash

ENV_FILE=".atxp/.env.production"

if [ ! -f "$ENV_FILE" ]; then
    echo "No environment variables configured yet."
    echo ""
    echo "To add variables, use:"
    echo "  /configure-env-var KEY VALUE"
    exit 0
fi

# Count non-empty, non-comment lines
VAR_COUNT=$(grep -cE '^[A-Za-z_][A-Za-z0-9_]*=' "$ENV_FILE" 2>/dev/null || echo "0")

if [ "$VAR_COUNT" -eq 0 ]; then
    echo "No environment variables configured yet."
    echo ""
    echo "To add variables, use:"
    echo "  /configure-env-var KEY VALUE"
    exit 0
fi

echo "Environment variables in .atxp/.env.production:"
echo ""

# Read and display each variable with masked value
while IFS= read -r line; do
    # Skip empty lines and comments
    if [ -z "$line" ] || echo "$line" | grep -qE '^\s*#'; then
        continue
    fi

    # Extract key and mask value
    if echo "$line" | grep -qE '^[A-Za-z_][A-Za-z0-9_]*='; then
        KEY=$(echo "$line" | cut -d= -f1)
        VALUE=$(echo "$line" | cut -d= -f2-)

        # Mask the value - show first 4 chars and ****
        if [ ${#VALUE} -le 4 ]; then
            MASKED="****"
        else
            FIRST_CHARS=$(echo "$VALUE" | cut -c1-4)
            MASKED="${FIRST_CHARS}...****"
        fi

        echo "  ${KEY}=${MASKED}"
    fi
done < "$ENV_FILE"

echo ""
echo "(${VAR_COUNT} variable(s) configured)"
echo ""
echo "To modify or add variables, use:"
echo "  /configure-env-var KEY VALUE"
echo ""
echo "To remove a variable, use:"
echo "  /remove-env-var KEY"
```

## Notes

- Variable values are masked to prevent accidental exposure
- Only shows the first 4 characters followed by `...****`
- Empty lines and comments are ignored
- To see actual values, view the `.atxp/.env.production` file directly

## Security

This command masks sensitive values by default. If you need to see the actual values for debugging, you can:

```bash
cat .atxp/.env.production
```

⚠️ Be careful when viewing or sharing the actual file contents.

## Related Commands

- `/configure-env-var` - Add or update an environment variable
- `/remove-env-var` - Remove an environment variable
- `/deploy` - Deploy your agent with environment variables
