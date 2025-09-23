# Neovim Configuration Makefile

.PHONY: test lint format clean help

# Run all tests
test:
	@echo "🧪 Running Neovim configuration tests..."
	@./scripts/test.sh

# Run linter (luacheck)
lint:
	@echo "🔍 Running linter..."
	@luacheck lua/ --config .luacheckrc

# Format code (stylua)
format:
	@echo "✨ Formatting code..."
	@stylua lua/

# Run both lint and test
check: lint test
	@echo "✅ All checks passed!"

# Clean up build artifacts
clean:
	@echo "🧹 Cleaning up..."
	@rm -rf .tests/site/pack/vendor/start/plenary.nvim

# Show help
help:
	@echo "Available commands:"
	@echo "  test    - Run all tests"
	@echo "  lint    - Run linter (luacheck)"
	@echo "  format  - Format code (stylua)"
	@echo "  check   - Run both lint and test"
	@echo "  clean   - Clean up build artifacts"
	@echo "  help    - Show this help message"
