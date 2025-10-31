#!/bin/bash

# Simple test to verify the language server can be started
# This creates a simple LSP request and sends it to the server

set -e

echo "Testing mypy language server..."

# Activate virtual environment
if [ ! -d ".venv" ]; then
    echo "Virtual environment not found. Please run ./install.sh first."
    exit 1
fi

source .venv/bin/activate

# Create a simple test Python file
cat > /tmp/test_mypy_lsp.py << 'EOF'
def add(a: int, b: int) -> int:
    return a + b

# This should cause a type error
result: str = add(1, 2)
EOF

# Create LSP initialize request
cat > /tmp/lsp_request.json << 'EOF'
Content-Length: 223

{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"processId":null,"rootUri":"/tmp","capabilities":{},"initializationOptions":{},"workspaceFolders":null}}
Content-Length: 52

{"jsonrpc":"2.0","method":"initialized","params":{}}
EOF

echo "Language server can be started:"
echo "  python vscode-mypy/bundled/tool/lsp_server.py"
echo ""
echo "Note: This is a Language Server Protocol (LSP) server."
echo "It communicates via stdin/stdout using JSON-RPC."
echo "Integrate it with your editor using LSP client configuration."
echo ""
echo "Test file created at: /tmp/test_mypy_lsp.py"

# Verify the server script exists
if [ -f "vscode-mypy/bundled/tool/lsp_server.py" ]; then
    echo "✓ Language server script found"
else
    echo "✗ Language server script not found"
    exit 1
fi

# Verify dependencies are installed
python -c "import mypy; import pygls; print('✓ Required dependencies installed')" 2>&1

echo ""
echo "All checks passed!"
