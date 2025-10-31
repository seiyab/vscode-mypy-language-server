#!/bin/bash

# Quick run script for mypy language server

set -e

# Check if virtual environment exists
if [ ! -d ".venv" ]; then
    echo "Virtual environment not found. Running installation script..."
    ./install.sh
fi

# Activate virtual environment
source .venv/bin/activate

# Run the language server
echo "Starting mypy language server..."
python vscode-mypy/bundled/tool/lsp_server.py "$@"
