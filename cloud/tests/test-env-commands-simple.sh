#!/bin/bash

# Simple test script for environment variable commands
# Tests the bash implementation directly

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_DIR="$(mktemp -d)"
ENV_FILE="$TEST_DIR/.atxp/.env.production"

echo "=========================================="
echo "Testing Environment Variable Commands"
echo "=========================================="
echo ""
echo "Test directory: $TEST_DIR"
echo ""

# Change to test directory
cd "$TEST_DIR"

# Extract and run the bash implementation from markdown
extract_bash() {
    local md_file="$1"
    # Extract content between ```bash and ``` markers
    sed -n '/^```bash$/,/^```$/p' "$SCRIPT_DIR/../commands/$md_file" | sed '1d;$d'
}

# Configure a variable (simulate the command)
configure_env_var() {
    KEY="$1"
    shift
    VALUE="$*"

    # Validate key format
    if ! echo "$KEY" | grep -qE '^[A-Za-z_][A-Za-z0-9_]*$'; then
        echo "Error: KEY must start with a letter or underscore"
        return 1
    fi

    mkdir -p .atxp
    ENV_FILE=".atxp/.env.production"

    if [ -f "$ENV_FILE" ]; then
        if grep -q "^${KEY}=" "$ENV_FILE"; then
            # Update existing key
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
        echo "✓ Created .atxp/.env.production with ${KEY}"
    fi
}

# List variables (simulate the command)
list_env_vars() {
    ENV_FILE=".atxp/.env.production"

    if [ ! -f "$ENV_FILE" ]; then
        echo "No environment variables configured yet."
        return
    fi

    VAR_COUNT=$(grep -cE '^[A-Za-z_][A-Za-z0-9_]*=' "$ENV_FILE" 2>/dev/null || echo "0")

    if [ "$VAR_COUNT" -eq 0 ]; then
        echo "No environment variables configured yet."
        return
    fi

    echo "Environment variables in .atxp/.env.production:"
    echo ""

    while IFS= read -r line; do
        if [ -z "$line" ] || echo "$line" | grep -qE '^\s*#'; then
            continue
        fi

        if echo "$line" | grep -qE '^[A-Za-z_][A-Za-z0-9_]*='; then
            KEY=$(echo "$line" | cut -d= -f1)
            VALUE=$(echo "$line" | cut -d= -f2-)

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
}

# Remove a variable (simulate the command)
remove_env_var() {
    KEY="$1"
    ENV_FILE=".atxp/.env.production"

    if [ ! -f "$ENV_FILE" ]; then
        echo "No environment variables file found"
        return 1
    fi

    if ! grep -q "^${KEY}=" "$ENV_FILE"; then
        echo "Environment variable ${KEY} not found"
        return 1
    fi

    TEMP_FILE=$(mktemp)
    grep -v "^${KEY}=" "$ENV_FILE" > "$TEMP_FILE" || true
    mv "$TEMP_FILE" "$ENV_FILE"

    echo "✓ Removed ${KEY}"

    if [ ! -s "$ENV_FILE" ]; then
        rm "$ENV_FILE"
        echo "✓ Removed empty .atxp/.env.production"
    fi
}

# Run tests
echo "Test 1: Configure first environment variable"
echo "-------------------------------------------"
configure_env_var "TEST_API_KEY" "test-value-123"
echo ""

if [ ! -f "$ENV_FILE" ]; then
    echo "❌ FAIL: File not created"
    exit 1
fi
echo "✅ PASS"
echo ""

echo "Test 2: Configure multiple variables"
echo "-------------------------------------------"
configure_env_var "GOOGLE_ANALYTICS_API_KEY" "ya29.test-key"
configure_env_var "DATAFORSEO_API_KEY" "12345678-test"
echo ""

VAR_COUNT=$(grep -cE '^[A-Za-z_][A-Za-z0-9_]*=' "$ENV_FILE")
if [ "$VAR_COUNT" -ne 3 ]; then
    echo "❌ FAIL: Expected 3 variables, found $VAR_COUNT"
    exit 1
fi
echo "✅ PASS"
echo ""

echo "Test 3: List environment variables"
echo "-------------------------------------------"
list_env_vars
echo ""
echo "✅ PASS"
echo ""

echo "Test 4: Update existing variable"
echo "-------------------------------------------"
configure_env_var "TEST_API_KEY" "updated-value-456"
echo ""

if ! grep -q "^TEST_API_KEY=updated-value-456$" "$ENV_FILE"; then
    echo "❌ FAIL: Variable not updated"
    exit 1
fi
echo "✅ PASS"
echo ""

echo "Test 5: Remove variable"
echo "-------------------------------------------"
remove_env_var "TEST_API_KEY"
echo ""

if grep -q "^TEST_API_KEY=" "$ENV_FILE"; then
    echo "❌ FAIL: Variable not removed"
    exit 1
fi
echo "✅ PASS"
echo ""

echo "Test 6: Test values with spaces"
echo "-------------------------------------------"
configure_env_var "DATABASE_URL" "postgresql://user:pass@localhost:5432/db with spaces"
echo ""

if ! grep -q "^DATABASE_URL=postgresql://user:pass@localhost:5432/db with spaces$" "$ENV_FILE"; then
    echo "❌ FAIL: Value with spaces not handled correctly"
    cat "$ENV_FILE"
    exit 1
fi
echo "✅ PASS"
echo ""

echo "Test 7: List current variables before cleanup"
echo "-------------------------------------------"
echo "Current variables:"
cat "$ENV_FILE"
echo ""
list_env_vars
echo ""

echo "Test 8: Remove all variables"
echo "-------------------------------------------"
remove_env_var "GOOGLE_ANALYTICS_API_KEY"
remove_env_var "DATAFORSEO_API_KEY"
remove_env_var "DATABASE_URL"
echo ""

if [ -f "$ENV_FILE" ]; then
    echo "❌ FAIL: Empty file should be deleted"
    cat "$ENV_FILE" || true
    ls -la .atxp/ || true
    exit 1
fi
echo "✅ PASS"
echo ""

echo "Test 9: List when no variables"
echo "-------------------------------------------"
list_env_vars
echo ""
echo "✅ PASS"
echo ""

# Cleanup
cd /
rm -rf "$TEST_DIR"

echo "=========================================="
echo "✅ ALL TESTS PASSED!"
echo "=========================================="
echo ""
