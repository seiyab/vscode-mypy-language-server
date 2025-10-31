"""Command-line interface for mypy language server."""

import runpy
import sys
from pathlib import Path


def main():
    """Entry point for the mypy language server."""
    # Get the path to the submodule's lsp_server.py
    package_dir = Path(__file__).parent.parent
    lsp_server_path = package_dir / "vscode-mypy" / "bundled" / "tool" / "lsp_server.py"
    
    if not lsp_server_path.exists():
        print(f"Error: Language server not found at {lsp_server_path}", file=sys.stderr)
        print("\nPlease ensure the git submodule is initialized:", file=sys.stderr)
        print("  git submodule update --init --recursive", file=sys.stderr)
        sys.exit(1)
    
    # Add the tool directory to Python path
    tool_dir = str(lsp_server_path.parent)
    if tool_dir not in sys.path:
        sys.path.insert(0, tool_dir)
    
    # Import and run the language server
    try:
        # Use runpy to execute the module safely
        runpy.run_path(str(lsp_server_path), run_name='__main__')
    except Exception as e:
        print(f"Error running language server: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
