# vscode-mypy-language-server

Mypy language server extracted from https://github.com/microsoft/vscode-mypy

This repository provides easy-to-use installation and execution scripts for the mypy language server implementation from Microsoft's vscode-mypy extension. The language server is included as a git submodule, ensuring you always have access to the official implementation.

## Features

- **Official Implementation**: Uses the language server directly from Microsoft's vscode-mypy repository
- **Multiple Installation Methods**: Shell scripts, PowerShell scripts, and pip-based installation
- **Quick Start Scripts**: Run the language server with a single command
- **Cross-Platform**: Support for Linux, macOS, and Windows

## Prerequisites

- Python 3.8 or higher
- Git (for cloning and submodule management)

## Installation

### Method 1: Using Installation Scripts (Recommended)

#### On Linux/macOS:

```bash
# Clone the repository
git clone https://github.com/seiyab/vscode-mypy-language-server.git
cd vscode-mypy-language-server

# Run the installation script
./install.sh
```

#### On Windows (PowerShell):

```powershell
# Clone the repository
git clone https://github.com/seiyab/vscode-mypy-language-server.git
cd vscode-mypy-language-server

# Run the installation script
.\install.ps1
```

The installation script will:
1. Initialize the git submodule (vscode-mypy)
2. Create a virtual environment
3. Install all required dependencies

### Method 2: Using pip (Development Install)

```bash
# Clone the repository with submodules
git clone --recurse-submodules https://github.com/seiyab/vscode-mypy-language-server.git
cd vscode-mypy-language-server

# Install in development mode
pip install -e .
```

### Method 3: Manual Setup

```bash
# Clone the repository
git clone https://github.com/seiyab/vscode-mypy-language-server.git
cd vscode-mypy-language-server

# Initialize the submodule
git submodule update --init --recursive

# Create and activate a virtual environment
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\Activate.ps1

# Install dependencies
pip install -r vscode-mypy/requirements.txt
```

## Testing the Installation

After installation, you can verify everything is working correctly:

```bash
./test_server.sh
```

This script will:
- Check that the language server script exists
- Verify all dependencies are installed
- Confirm the server can be started

## Usage

### Quick Start

#### On Linux/macOS:

```bash
# Run the language server
./run_lsp_server.sh
```

#### On Windows (PowerShell):

```powershell
# Run the language server
.\run_lsp_server.ps1
```

### Manual Start

If you installed using pip:

```bash
mypy-lsp
```

Or directly with Python:

```bash
# Activate the virtual environment first
source .venv/bin/activate  # On Windows: .venv\Scripts\Activate.ps1

# Run the language server
python vscode-mypy/bundled/tool/lsp_server.py
```

### Integration with Editors

The language server communicates via stdin/stdout using the Language Server Protocol (LSP). Configure your editor to use this language server for Python files with mypy type checking.

#### Example for Neovim (using nvim-lspconfig):

```lua
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

-- Define custom mypy language server
if not configs.mypy_lsp then
  configs.mypy_lsp = {
    default_config = {
      cmd = {'/path/to/vscode-mypy-language-server/run_lsp_server.sh'},
      filetypes = {'python'},
      root_dir = lspconfig.util.root_pattern('.git', 'pyproject.toml', 'setup.py'),
      settings = {},
    },
  }
end

lspconfig.mypy_lsp.setup{}
```

#### Example for VSCode:

Add to your `settings.json`:

```json
{
  "python.linting.mypyEnabled": true,
  "python.linting.mypyPath": "/path/to/vscode-mypy-language-server/run_lsp_server.sh"
}
```

## Updating the Language Server

To update to the latest version of the language server from the upstream vscode-mypy repository:

```bash
# Update the submodule
git submodule update --remote vscode-mypy

# Reinstall dependencies if needed
./install.sh
```

## Project Structure

```
vscode-mypy-language-server/
├── vscode-mypy/                 # Git submodule containing the language server
│   └── bundled/tool/
│       └── lsp_server.py       # Main language server implementation
├── install.sh                   # Installation script (Linux/macOS)
├── install.ps1                  # Installation script (Windows)
├── run_lsp_server.sh           # Quick run script (Linux/macOS)
├── run_lsp_server.ps1          # Quick run script (Windows)
├── pyproject.toml              # Python package configuration
└── README.md                   # This file
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

The language server implementation is from [microsoft/vscode-mypy](https://github.com/microsoft/vscode-mypy), which is also under the MIT License.

## Acknowledgments

- The mypy language server implementation is provided by Microsoft's vscode-mypy extension
- This repository simply provides convenient installation and execution methods
