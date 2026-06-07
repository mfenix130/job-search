#!/usr/bin/env bash
set -euo pipefail

# ─────────────────────────────────────────────
# job-search dependency installer
# Installs: pandoc, pdftotext (poppler), python-docx
# Supports: macOS (Homebrew), Debian/Ubuntu (apt)
# ─────────────────────────────────────────────

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

ok()   { echo -e "${GREEN}[ok]${NC}    $1"; }
warn() { echo -e "${YELLOW}[warn]${NC}  $1"; }
fail() { echo -e "${RED}[fail]${NC}  $1"; }
info() { echo -e "        $1"; }

echo ""
echo "job-search install"
echo "────────────────────────────────────────"

# ── Claude Code ───────────────────────────────
echo ""
echo "Checking Claude Code..."
if command -v claude &>/dev/null; then
  ok "claude $(claude --version 2>/dev/null | head -1)"
else
  fail "Claude Code not found."
  info "Install it from: https://claude.ai/code"
  info "This repo requires Claude Code to run the agent and skills."
  MISSING_CLAUDE=1
fi

# ── Detect OS / package manager ──────────────
echo ""
echo "Detecting platform..."
if [[ "$OSTYPE" == "darwin"* ]]; then
  PLATFORM="macos"
  if command -v brew &>/dev/null; then
    ok "macOS — Homebrew $(brew --version | head -1)"
  else
    fail "Homebrew not found. Install it first: https://brew.sh"
    exit 1
  fi
elif command -v apt-get &>/dev/null; then
  PLATFORM="debian"
  ok "Linux — apt"
else
  warn "Unrecognised platform. Install pandoc and poppler-utils manually."
  warn "Then run: pip install -r requirements.txt"
  PLATFORM="unknown"
fi

# ── pandoc ────────────────────────────────────
echo ""
echo "Checking pandoc (DOCX/DOC extraction)..."
if command -v pandoc &>/dev/null; then
  ok "pandoc $(pandoc --version | head -1)"
else
  warn "pandoc not found — installing..."
  if [[ "$PLATFORM" == "macos" ]]; then
    brew install pandoc
    ok "pandoc installed"
  elif [[ "$PLATFORM" == "debian" ]]; then
    sudo apt-get update -qq && sudo apt-get install -y pandoc
    ok "pandoc installed"
  else
    fail "Install pandoc manually: https://pandoc.org/installing.html"
  fi
fi

# ── pdftotext (poppler) ───────────────────────
echo ""
echo "Checking pdftotext (PDF extraction)..."
if command -v pdftotext &>/dev/null; then
  ok "pdftotext $(pdftotext -v 2>&1 | head -1)"
else
  warn "pdftotext not found — installing poppler..."
  if [[ "$PLATFORM" == "macos" ]]; then
    brew install poppler
    ok "poppler (pdftotext) installed"
  elif [[ "$PLATFORM" == "debian" ]]; then
    sudo apt-get update -qq && sudo apt-get install -y poppler-utils
    ok "poppler-utils (pdftotext) installed"
  else
    fail "Install poppler manually — provides pdftotext"
  fi
fi

# ── Python 3 ─────────────────────────────────
echo ""
echo "Checking Python 3 (python-docx fallback)..."
if command -v python3 &>/dev/null; then
  ok "$(python3 --version)"
else
  warn "python3 not found — installing..."
  if [[ "$PLATFORM" == "macos" ]]; then
    brew install python3
    ok "python3 installed"
  elif [[ "$PLATFORM" == "debian" ]]; then
    sudo apt-get update -qq && sudo apt-get install -y python3 python3-pip
    ok "python3 installed"
  else
    fail "Install Python 3 manually: https://www.python.org/downloads/"
  fi
fi

# ── python-docx ──────────────────────────────
echo ""
echo "Checking python-docx..."
if python3 -c "import docx" &>/dev/null; then
  ok "python-docx already installed"
else
  warn "python-docx not found — installing..."
  python3 -m pip install --quiet -r requirements.txt
  ok "python-docx installed"
fi

# ── applications/ directory ───────────────────
echo ""
echo "Checking workspace directory..."
if [[ -d "applications" ]]; then
  ok "applications/ exists"
else
  mkdir -p applications
  ok "applications/ created"
fi

# ── Summary ───────────────────────────────────
echo ""
echo "────────────────────────────────────────"
if [[ -n "${MISSING_CLAUDE:-}" ]]; then
  warn "Setup complete — but Claude Code is required to use the agent."
  info "Install Claude Code from https://claude.ai/code, then re-run this script."
else
  ok "All dependencies installed."
  echo ""
  echo "Available skills (no extra installation needed — they are files in this repo):"
  echo ""
  info "  agent/SKILL.md              ← orchestrator: runs the full workflow"
  info "  skills/job-ingestion/       ← fetch and synthesise job postings"
  info "  skills/company-research/    ← research target companies"
  info "  skills/resume-reviewer/     ← blunt hiring-manager audit"
  info "  skills/resume-tailor/       ← rewrite weak bullets"
  echo ""
  echo "How to use:"
  echo ""
  info "  1. Open this project in Claude Code:"
  info ""
  info "       claude"
  info ""
  info "  2. In the Claude Code chat, type this (it is a chat message, not a shell command):"
  info ""
  info "       Use the job-search agent for:"
  info "       - Resume: /path/to/resume.pdf"
  info "       - Application name: company-role"
  info "       - Job sources: <LinkedIn URLs or .txt files>"
  info "       - Target companies: <company names>"
  echo ""
  info "  Claude Code reads agent/SKILL.md and runs all stages automatically."
  info "  Output lands in applications/<company-role>/."
fi
echo ""
