#!/bin/bash

# Installation script for mypy language server
# This script sets up the language server from the vscode-mypy submodule

set -e

echo "==================================="
echo "Mypy Language Server Installer"
echo "==================================="
echo ""

# Check if git submodule is initialized
if [ ! -f "vscode-mypy/bundled/tool/lsp_server.py" ]; then
    echo "Initializing git submodule..."
    git submodule update --init --recursive
fi

# Check Python installation
if ! command -v python3 &> /dev/null; then
    echo "Error: python3 is not installed. Please install Python 3.8 or higher."
    exit 1
fi

PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
echo "Using Python $PYTHON_VERSION"

# Create virtual environment if it doesn't exist
if [ ! -d ".venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv .venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
source .venv/bin/activate

# Install dependencies
echo "Installing dependencies..."
python3 -m pip install --upgrade pip
python3 -m pip install -r vscode-mypy/requirements.txt

echo ""
echo "==================================="
echo "Installation completed successfully!"
echo "==================================="
echo ""
echo "To use the language server:"
echo "  1. Activate the virtual environment: source .venv/bin/activate"
echo "  2. Run the server: python vscode-mypy/bundled/tool/lsp_server.py"
echo ""
echo "Or use the run script: ./run_lsp_server.sh"
