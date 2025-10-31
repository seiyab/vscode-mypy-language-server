# Quick run script for mypy language server (Windows)

# Check if virtual environment exists
if (-not (Test-Path ".venv")) {
    Write-Host "Virtual environment not found. Running installation script..." -ForegroundColor Yellow
    & ".\install.ps1"
}

# Activate virtual environment
& ".\.venv\Scripts\Activate.ps1"

# Run the language server
Write-Host "Starting mypy language server..." -ForegroundColor Green
python vscode-mypy\bundled\tool\lsp_server.py $args
