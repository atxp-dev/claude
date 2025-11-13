# Deploy Command Tests

Automated tests for the `/deploy` command to ensure file exclusions work correctly.

## Running Tests

```bash
./tests/test-deploy-exclusions.sh
```

## What It Tests

The test suite creates a comprehensive test project with various file types and verifies that:

### Files Included ✅
- `.atxp/.env.production` - Production environment variables (needed for sandbox)
- `config/.env` - Application configuration
- Application code files (`index.js`, `src/app.js`)

### Files Excluded 🔒
- **Environment files**: `.env.local`, `.env.production.local`, `.env.development`, `.env.test`
- **Credentials**: `.npmrc`, `.netrc`, `.aws/credentials`
- **Certificates**: `*.pem`, `*.key`, `*.p12`, `*.pfx`
- **Git files**: `.git/*`
- **Dependencies**: `node_modules/*`, `*/node_modules/*` (nested)
- **macOS metadata**: `.DS_Store` files
- **Instance tracking**: `.atxp-instance`

## Exit Codes

- `0` - All tests passed
- `1` - One or more tests failed

## CI/CD Integration

This test can be run as part of CI/CD pipelines to ensure deploy exclusions remain correct:

```yaml
# Example GitHub Actions
- name: Test deploy exclusions
  run: ./cloud/tests/test-deploy-exclusions.sh
```

## Test Output

The script provides colored output with clear pass/fail indicators and a summary of all tests run.
