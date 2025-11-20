# Testing Environment Variable Commands

This guide explains how to test the environment variable management commands (`/configure-env-var`, `/list-env-vars`, `/remove-env-var`) in Claude Code.

## Prerequisites

The cloud plugin must be installed in your project for these commands to be available.

## Testing Approaches

### Approach 1: Test in a Real Project (Recommended)

The best way to test these commands is in an actual project that will use them:

1. **Create or navigate to a project directory:**
   ```bash
   cd ~/projects/my-agent-project
   ```

2. **Install the cloud plugin** (if testing from the published marketplace):
   ```bash
   # In Claude Code:
   /plugin marketplace add atxp-dev/claude
   /plugin install cloud@atxp
   ```

3. **Or, for local testing**, link to your local development version:
   ```bash
   # In the marketplace repo:
   cd /path/to/atxp/claude

   # In your test project:
   cd ~/projects/my-agent-project

   # Create a local plugin reference (if supported)
   # Or copy the cloud directory to test locally
   ```

4. **Start a Claude Code session** in your project directory

5. **Test the commands:**
   ```
   /configure-env-var DEMO_KEY demo-value-123
   /list-env-vars
   /remove-env-var DEMO_KEY
   ```

### Approach 2: Test Within the Marketplace Repo

If you're developing the plugin within this repository:

1. **Stay in the marketplace directory:**
   ```bash
   cd /path/to/atxp/claude
   ```

2. **The commands SHOULD be available** because the plugin definitions are in this repo

3. **Try the commands in Claude Code:**
   ```
   /configure-env-var TEST_KEY test-value
   /list-env-vars
   ```

4. **If commands aren't recognized,** it may be because Claude Code doesn't recognize this as a project using the plugins, but rather as the marketplace source itself

### Approach 3: Manual Testing with Bash

For development/debugging purposes, you can test the bash implementation directly:

```bash
# Navigate to the repo
cd /path/to/atxp/claude

# Extract and test the bash code from the markdown files
# (The bash code is in the ```bash blocks in the .md files)

# Example: Test configure-env-var
KEY="TEST_KEY"
VALUE="test-value-123"

mkdir -p .atxp
ENV_FILE=".atxp/.env.production"

if [ -f "$ENV_FILE" ]; then
    if grep -q "^${KEY}=" "$ENV_FILE"; then
        TEMP_FILE=$(mktemp)
        while IFS= read -r line; do
            if echo "$line" | grep -q "^${KEY}="; then
                echo "${KEY}=${VALUE}"
            else
                echo "$line"
            fi
        done < "$ENV_FILE" > "$TEMP_FILE"
        mv "$TEMP_FILE" "$ENV_FILE"
        echo "✓ Updated ${KEY}"
    else
        echo "${KEY}=${VALUE}" >> "$ENV_FILE"
        echo "✓ Added ${KEY}"
    fi
else
    echo "${KEY}=${VALUE}" > "$ENV_FILE"
    echo "✓ Created ${KEY}"
fi

# Verify
cat .atxp/.env.production
```

### Approach 4: Automated Test Suite

We've provided an automated test suite that validates all command functionality:

```bash
# Run the test suite
./cloud/tests/test-env-commands-simple.sh
```

This tests:
- Creating variables
- Updating variables
- Listing variables (with masking)
- Removing variables
- Edge cases (empty file, spaces in values, etc.)

## Test Cases

### Test 1: Basic Configuration

```
User: /configure-env-var MY_API_KEY abc123def456

Expected Output:
✓ Created .atxp/.env.production with MY_API_KEY

Next steps:
  1. Review variables: /list-env-vars
  2. Deploy your agent: /deploy
```

Verify:
- `.atxp/.env.production` file exists
- Contains `MY_API_KEY=abc123def456`
- File is NOT in git status (ignored)

### Test 2: List Variables

```
User: /list-env-vars

Expected Output:
Environment variables in .atxp/.env.production:

  MY_API_KEY=abc1...****

(1 variable(s) configured)
```

Verify:
- Values are masked (first 4 chars + ...****)
- Count is accurate

### Test 3: Update Variable

```
User: /configure-env-var MY_API_KEY new-value-789

Expected Output:
✓ Updated MY_API_KEY in .atxp/.env.production

Next steps:
  1. Review variables: /list-env-vars
  2. Deploy your agent: /deploy
```

Verify:
- File contains only one `MY_API_KEY` line
- Value is updated to `new-value-789`
- No duplicate entries

### Test 4: Multiple Variables

```
User: /configure-env-var GOOGLE_API_KEY ya29.example
User: /configure-env-var DATAFORSEO_KEY 12345-example
User: /list-env-vars

Expected Output:
Environment variables in .atxp/.env.production:

  MY_API_KEY=new-...****
  GOOGLE_API_KEY=ya29...****
  DATAFORSEO_KEY=1234...****

(3 variable(s) configured)
```

### Test 5: Remove Variable

```
User: /remove-env-var MY_API_KEY

Expected Output:
✓ Removed MY_API_KEY from .atxp/.env.production

Next steps:
  1. Review remaining variables: /list-env-vars
  2. Deploy your agent: /deploy
```

Verify:
- Variable is removed from file
- Other variables remain intact
- No empty lines or corruption

### Test 6: Remove All Variables

```
User: /remove-env-var GOOGLE_API_KEY
User: /remove-env-var DATAFORSEO_KEY

Expected Output:
✓ Removed DATAFORSEO_KEY from .atxp/.env.production
✓ Removed empty .atxp/.env.production
```

Verify:
- `.atxp/.env.production` file is deleted when empty
- `.atxp/` directory may remain (that's OK)

### Test 7: Error Cases

**Non-existent variable:**
```
User: /remove-env-var DOES_NOT_EXIST

Expected Output:
Environment variable DOES_NOT_EXIST not found in .atxp/.env.production

To see all configured variables, use:
  /list-env-vars
```

**Invalid key format:**
```
User: /configure-env-var 123-INVALID value

Expected Output:
Error: KEY must start with a letter or underscore and contain only alphanumeric characters and underscores
```

**No variables configured:**
```
User: /list-env-vars

Expected Output:
No environment variables configured yet.

To add variables, use:
  /configure-env-var KEY VALUE
```

### Test 8: Values with Special Characters

```
User: /configure-env-var DATABASE_URL postgresql://user:pass@localhost:5432/db

Expected Output:
✓ Added DATABASE_URL to .atxp/.env.production
```

Verify:
- Special characters (://@ etc.) are preserved
- No escaping or corruption

**Values with spaces:**
```
User: /configure-env-var MESSAGE Hello World Testing

Expected Output:
✓ Added MESSAGE to .atxp/.env.production
```

Verify:
- File contains `MESSAGE=Hello World Testing`
- Spaces are preserved

### Test 9: Integration with Deploy

```
User: /configure-env-var API_KEY test-key
User: /deploy

Expected Behavior:
- .atxp/.env.production is included in the deployment zip
- File is uploaded to cloud.atxp.ai
- Variables are available to the deployed agent at runtime
```

Verify:
- Check deploy output mentions including environment files
- Or inspect the zip file created during deploy

### Test 10: Security - Git Ignore

```bash
# In terminal:
/configure-env-var SECRET_KEY secret-value-do-not-commit
git status

Expected:
# Should NOT show .atxp/.env.production as untracked
```

Verify:
- `.atxp/.env.production` is in `.gitignore`
- File does not appear in `git status`
- Cannot be accidentally committed

## Troubleshooting

### Commands Not Recognized

**Problem:** `/configure-env-var` shows "Unknown slash command"

**Solutions:**
1. Ensure you're in a project with the cloud plugin installed
2. Check if the plugin is listed: `/plugin list`
3. Try reinstalling: `/plugin install cloud@atxp`
4. Verify you're on the correct branch with the new commands

### Commands Don't Create Files

**Problem:** Commands run but no `.atxp/.env.production` is created

**Solutions:**
1. Check current directory: `pwd`
2. Look for error messages in command output
3. Verify write permissions: `ls -la .`
4. Try creating manually: `mkdir -p .atxp && touch .atxp/.env.production`

### Values Not Masked in List

**Problem:** `/list-env-vars` shows full values instead of masked

**Solutions:**
1. Check if you're using the correct command version
2. Verify the bash implementation in `cloud/commands/list-env-vars.md`
3. Test with the automated suite: `./cloud/tests/test-env-commands-simple.sh`

### Gitignore Not Working

**Problem:** `.atxp/.env.production` appears in `git status`

**Solutions:**
1. Verify `.gitignore` contains `.atxp/.env.production`
2. Check if file was already tracked: `git rm --cached .atxp/.env.production`
3. Verify gitignore syntax: `cat .gitignore`

## Reporting Issues

If you encounter bugs or unexpected behavior:

1. Run the automated test suite: `./cloud/tests/test-env-commands-simple.sh`
2. Note which test fails
3. Collect debug info:
   - Command executed
   - Expected vs actual output
   - Contents of `.atxp/.env.production`
   - Git status output
4. Open an issue with reproduction steps

## Development

When making changes to the commands:

1. Update the markdown files in `cloud/commands/`
2. Update the test suite in `cloud/tests/test-env-commands-simple.sh`
3. Run tests: `./cloud/tests/test-env-commands-simple.sh`
4. Test manually in Claude Code
5. Update this TESTING.md with any new test cases
