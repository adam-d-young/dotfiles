#!/usr/bin/env bash

# Pre-commit hook for Neovim configuration
# This script runs linting and tests before allowing a commit

set -euo pipefail

echo "🔍 Running pre-commit checks..."

# Change to the nvim directory
cd "$(dirname "$0")/.."

# Run linting and tests
make check

echo "✅ Pre-commit checks passed!"
