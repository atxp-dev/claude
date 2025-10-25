---
name: deploy
description: Deploy the current working directory as a Claude agent to cloud.atxp.ai
---

# Deploy Command

This command packages and deploys the current working directory to cloud.atxp.ai.

## Prerequisites

- `ATXP_CONNECTION_STRING` environment variable must be set with your ATXP connection URL
- The connection string should contain a `connection_token` query parameter
- `curl` and `jq` must be available in your PATH

## Steps

### 1. Extract the connection token from ATXP_CONNECTION_STRING

The connection token is a query parameter in the connection URL:

```bash
# Extract connection_token from the URL
CONNECTION_TOKEN=$(echo "$ATXP_CONNECTION_STRING" | grep -o 'connection_token=[^&]*' | cut -d= -f2)

if [ -z "$CONNECTION_TOKEN" ]; then
  echo "Error: Could not extract connection_token from ATXP_CONNECTION_STRING"
  exit 1
fi
```

### 2. Create a zip file of the current directory

```bash
# Create a temporary zip file
ZIP_FILE=$(mktemp /tmp/deploy-XXXXXX.zip)
echo "Creating deployment package..."

# Zip the current directory, excluding common files
zip -r "$ZIP_FILE" . \
  -x "*.git/*" \
  -x "node_modules/*" \
  -x ".atxp-instance" \
  -x "*.DS_Store" \
  -x "*/.*" \
  > /dev/null

echo "Package created: $(du -h "$ZIP_FILE" | cut -f1)"
```

### 3. Check for existing instance ID

The instance ID is stored in `.atxp-instance` in the current directory:

```bash
INSTANCE_FILE=".atxp-instance"
INSTANCE_ID=""

if [ -f "$INSTANCE_FILE" ]; then
  INSTANCE_ID=$(cat "$INSTANCE_FILE")
  echo "Found existing instance: $INSTANCE_ID"
fi
```

### 4. Upload to cloud.atxp.ai

Create the authorization header using Basic Auth:

```bash
# Create Basic Auth header: base64(TOKEN:)
AUTH_HEADER="Authorization: Basic $(echo -n "${CONNECTION_TOKEN}:" | base64)"
```

Upload the zip file (create new or update existing):

```bash
if [ -z "$INSTANCE_ID" ]; then
  # Create new instance
  echo "Deploying new instance..."
  RESPONSE=$(curl -X POST https://cloud.atxp.ai/upload \
    -H "$AUTH_HEADER" \
    -F "file=@$ZIP_FILE" \
    -s)
else
  # Update existing instance
  echo "Updating instance $INSTANCE_ID..."
  RESPONSE=$(curl -X POST "https://cloud.atxp.ai/upload/$INSTANCE_ID" \
    -H "$AUTH_HEADER" \
    -F "file=@$ZIP_FILE" \
    -s)
fi

# Clean up temporary zip file
rm "$ZIP_FILE"
```

### 5. Parse response and store instance ID

```bash
# Check if upload was successful
SUCCESS=$(echo "$RESPONSE" | jq -r '.success')

if [ "$SUCCESS" = "true" ]; then
  INSTANCE_ID=$(echo "$RESPONSE" | jq -r '.instanceId')
  MESSAGE=$(echo "$RESPONSE" | jq -r '.message')

  # Store instance ID for future deploys
  echo "$INSTANCE_ID" > "$INSTANCE_FILE"

  echo "✓ Deployment successful!"
  echo "Instance ID: $INSTANCE_ID"
  echo "$MESSAGE"
else
  echo "✗ Deployment failed"
  echo "$RESPONSE" | jq -r '.message // .error // .'
  exit 1
fi
```

## Complete Script

Here's the complete deployment script:

```bash
#!/bin/bash

# Extract connection token
CONNECTION_TOKEN=$(echo "$ATXP_CONNECTION_STRING" | grep -o 'connection_token=[^&]*' | cut -d= -f2)

if [ -z "$CONNECTION_TOKEN" ]; then
  echo "Error: Could not extract connection_token from ATXP_CONNECTION_STRING"
  exit 1
fi

# Create zip file
ZIP_FILE=$(mktemp /tmp/deploy-XXXXXX.zip)
echo "Creating deployment package..."
zip -r "$ZIP_FILE" . \
  -x "*.git/*" \
  -x "node_modules/*" \
  -x ".atxp-instance" \
  -x "*.DS_Store" \
  -x "*/.*" \
  > /dev/null
echo "Package created: $(du -h "$ZIP_FILE" | cut -f1)"

# Check for existing instance
INSTANCE_FILE=".atxp-instance"
INSTANCE_ID=""
if [ -f "$INSTANCE_FILE" ]; then
  INSTANCE_ID=$(cat "$INSTANCE_FILE")
  echo "Found existing instance: $INSTANCE_ID"
fi

# Create auth header
AUTH_HEADER="Authorization: Basic $(echo -n "${CONNECTION_TOKEN}:" | base64)"

# Upload
if [ -z "$INSTANCE_ID" ]; then
  echo "Deploying new instance..."
  RESPONSE=$(curl -X POST https://cloud.atxp.ai/upload \
    -H "$AUTH_HEADER" \
    -F "file=@$ZIP_FILE" \
    -s)
else
  echo "Updating instance $INSTANCE_ID..."
  RESPONSE=$(curl -X POST "https://cloud.atxp.ai/upload/$INSTANCE_ID" \
    -H "$AUTH_HEADER" \
    -F "file=@$ZIP_FILE" \
    -s)
fi

# Clean up
rm "$ZIP_FILE"

# Parse response
SUCCESS=$(echo "$RESPONSE" | jq -r '.success')

if [ "$SUCCESS" = "true" ]; then
  INSTANCE_ID=$(echo "$RESPONSE" | jq -r '.instanceId')
  MESSAGE=$(echo "$RESPONSE" | jq -r '.message')

  echo "$INSTANCE_ID" > "$INSTANCE_FILE"

  echo "✓ Deployment successful!"
  echo "Instance ID: $INSTANCE_ID"
  echo "$MESSAGE"
else
  echo "✗ Deployment failed"
  echo "$RESPONSE" | jq -r '.message // .error // .'
  exit 1
fi
```

## Error Handling

Possible errors:

- **400 Bad Request**: Invalid file type or no file uploaded
- **401 Unauthorized**: Invalid or missing connection token
- **403 Forbidden**: Trying to update an instance you don't own
- **404 Not Found**: Instance ID not found (stored ID may be stale)
- **500 Internal Server Error**: Server error during upload

If you receive a 404 error on update, delete the `.atxp-instance` file and try again to create a new instance.
