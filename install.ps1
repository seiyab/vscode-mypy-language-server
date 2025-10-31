# Installation script for mypy language server (Windows)
# This script sets up the language server from the vscode-mypy submodule

Write-Host "===================================" -ForegroundColor Cyan
Write-Host "Mypy Language Server Installer" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan
Write-Host ""

# Check if git submodule is initialized
if (-not (Test-Path "vscode-mypy\bundled\tool\lsp_server.py")) {
    Write-Host "Initializing git submodule..." -ForegroundColor Yellow
    git submodule update --init --recursive
}

# Check Python installation
try {
    $pythonVersion = (python --version 2>&1)
    Write-Host "Using $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: Python is not installed. Please install Python 3.8 or higher." -ForegroundColor Red
    exit 1
}

# Create virtual environment if it doesn't exist
if (-not (Test-Path ".venv")) {
    Write-Host "Creating virtual environment..." -ForegroundColor Yellow
    python -m venv .venv
}

# Activate virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Yellow
& ".\.venv\Scripts\Activate.ps1"

# Install dependencies
Write-Host "Installing dependencies..." -ForegroundColor Yellow
python -m pip install --upgrade pip
python -m pip install -r vscode-mypy\requirements.txt

Write-Host ""
Write-Host "===================================" -ForegroundColor Green
Write-Host "Installation completed successfully!" -ForegroundColor Green
Write-Host "===================================" -ForegroundColor Green
Write-Host ""
Write-Host "To use the language server:" -ForegroundColor Cyan
Write-Host "  1. Activate the virtual environment: .\.venv\Scripts\Activate.ps1"
Write-Host "  2. Run the server: python vscode-mypy\bundled\tool\lsp_server.py"
Write-Host ""
Write-Host "Or use the run script: .\run_lsp_server.ps1"
