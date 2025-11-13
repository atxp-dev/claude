#!/bin/bash
#
# Test script for deploy command file exclusions
# Verifies that sensitive files are excluded and necessary files are included
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Logging functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Test assertion functions
assert_file_included() {
    local file=$1
    TESTS_RUN=$((TESTS_RUN + 1))
    if unzip -l "$ZIP_FILE" | grep -q "$file"; then
        log_info "✓ File INCLUDED: $file"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        log_error "✗ File MISSING (should be included): $file"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_file_excluded() {
    local file=$1
    TESTS_RUN=$((TESTS_RUN + 1))
    if unzip -l "$ZIP_FILE" | grep -q "$file"; then
        log_error "✗ File INCLUDED (should be excluded): $file"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    else
        log_info "✓ File EXCLUDED: $file"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    fi
}

# Create test project
create_test_project() {
    log_info "Creating test project..."

    TEST_DIR=$(mktemp -d /tmp/test-deploy-XXXXXX)
    cd "$TEST_DIR"

    # Create directory structure
    mkdir -p .atxp .aws .git config packages/foo/node_modules node_modules src

    # Files that SHOULD be included
    echo "PROD_KEY=secret123" > .atxp/.env.production
    echo "APP_PORT=3000" > config/.env
    echo "console.log('app');" > index.js
    echo "export const foo = 'bar';" > src/app.js

    # Files that SHOULD be excluded - credentials
    echo "LOCAL_KEY=local123" > .env.local
    echo "PROD_LOCAL=secret" > .env.production.local
    echo "DEV_KEY=dev123" > .env.development
    echo "TEST_KEY=test123" > .env.test
    echo "//registry.npmjs.org/:_authToken=secret-token" > .npmrc
    echo "machine api.github.com login token password ghp_secret" > .netrc
    echo "aws_access_key_id=AKIAIOSFODNN7EXAMPLE" > .aws/credentials

    # Files that SHOULD be excluded - git
    echo "[core]" > .git/config

    # Files that SHOULD be excluded - node_modules
    echo "module.exports = {}" > node_modules/test-package.js
    echo "module.exports = {}" > packages/foo/node_modules/nested-package.js

    # Files that SHOULD be excluded - certificates
    echo "-----BEGIN RSA PRIVATE KEY-----" > id_rsa.pem
    echo "-----BEGIN PRIVATE KEY-----" > private.key
    echo "PKCS12" > cert.p12
    echo "PFX" > cert.pfx

    # Files that SHOULD be excluded - macOS
    touch .DS_Store
    touch src/.DS_Store

    # Files that SHOULD be excluded - atxp instance tracking
    echo "test-instance-id" > .atxp-instance

    log_info "Test project created at: $TEST_DIR"
    log_info "Total files created: $(find . -type f | wc -l | tr -d ' ')"
}

# Run the zip command (from deploy.md)
create_zip() {
    log_info "Creating ZIP file..."

    ZIP_FILE="$(mktemp /tmp/deploy-XXXXXX).zip"

    zip -r "$ZIP_FILE" . \
      -x ".git/*" \
      -x "node_modules/*" \
      -x "*/node_modules/*" \
      -x ".atxp-instance" \
      -x ".DS_Store" \
      -x "*/.DS_Store" \
      -x ".env.local" \
      -x ".env.*.local" \
      -x "*/.env.local" \
      -x "*/.env.*.local" \
      -x ".env.development" \
      -x "*/.env.development" \
      -x ".env.test" \
      -x "*/.env.test" \
      -x ".npmrc" \
      -x "*/.npmrc" \
      -x ".netrc" \
      -x "*/.netrc" \
      -x ".aws/*" \
      -x "*/.aws/*" \
      -x "*.pem" \
      -x "*.key" \
      -x "*.p12" \
      -x "*.pfx" \
      > /dev/null 2>&1

    log_info "ZIP file created: $ZIP_FILE"
    log_info "ZIP file size: $(du -h "$ZIP_FILE" | cut -f1)"
    log_info "Files in ZIP: $(unzip -l "$ZIP_FILE" | grep -E '^[ ]+[0-9]' | wc -l | tr -d ' ')"
}

# Run all tests
run_tests() {
    log_info "Running inclusion tests..."

    # Files that SHOULD be included
    assert_file_included ".atxp/.env.production"
    assert_file_included "config/.env"
    assert_file_included "index.js"
    assert_file_included "src/app.js"

    log_info "Running exclusion tests..."

    # Environment files
    assert_file_excluded ".env.local"
    assert_file_excluded ".env.production.local"
    assert_file_excluded ".env.development"
    assert_file_excluded ".env.test"

    # Credentials
    assert_file_excluded ".npmrc"
    assert_file_excluded ".netrc"
    assert_file_excluded ".aws/credentials"

    # Git
    assert_file_excluded ".git/config"

    # Node modules
    assert_file_excluded "node_modules/test-package.js"
    assert_file_excluded "packages/foo/node_modules/nested-package.js"

    # Certificates
    assert_file_excluded "id_rsa.pem"
    assert_file_excluded "private.key"
    assert_file_excluded "cert.p12"
    assert_file_excluded "cert.pfx"

    # macOS
    assert_file_excluded ".DS_Store"
    assert_file_excluded "src/.DS_Store"

    # ATXP instance tracking
    assert_file_excluded ".atxp-instance"
}

# Cleanup
cleanup() {
    log_info "Cleaning up..."
    rm -rf "$TEST_DIR"
    rm -f "$ZIP_FILE"
    log_info "Cleanup complete"
}

# Main execution
main() {
    echo ""
    log_info "=========================================="
    log_info "Deploy Command Exclusion Tests"
    log_info "=========================================="
    echo ""

    create_test_project
    create_zip
    echo ""
    run_tests
    echo ""
    cleanup

    # Print summary
    echo ""
    log_info "=========================================="
    log_info "Test Summary"
    log_info "=========================================="
    log_info "Tests run: $TESTS_RUN"
    log_info "Tests passed: $TESTS_PASSED"
    log_info "Tests failed: $TESTS_FAILED"
    echo ""

    if [ $TESTS_FAILED -eq 0 ]; then
        log_info "✓ All tests passed!"
        exit 0
    else
        log_error "✗ Some tests failed"
        exit 1
    fi
}

# Run main
main
