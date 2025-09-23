#!/bin/bash
# Test runner for Neovim configuration
# Usage: ./scripts/test.sh

set -e

echo "🧪 Running Neovim configuration tests..."
echo "========================================"

# Change to the nvim directory
cd "$(dirname "$0")/.."

# Run tests using plenary test harness
nvim --headless \
  -c "lua require('plenary.test_harness').test_directory('tests', {minimal_init = 'tests/minimal_init.lua'})" \
  -c "quit"

echo "========================================"
echo "✅ Tests completed!"
