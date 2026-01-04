#!/usr/bin/env bash

# init-agents.sh - One-click setup for multi-agent development
# Run this once after cloning a repo from the civics-template
#
# Usage:
#   ./init-agents.sh
#
# What it does:
#   1. Detects your repo name and path automatically
#   2. Creates three worktrees (claude, codex, gemini)
#   3. Opens each worktree in its own VS Code window
#   4. Prints a summary of what to do next

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() { echo -e "${BLUE}→${NC} $*"; }
success() { echo -e "${GREEN}✓${NC} $*"; }
warn() { echo -e "${YELLOW}⚠${NC} $*"; }
error() { echo -e "${RED}✗${NC} $*" >&2; }

# Check we're in a git repo
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    error "Not inside a Git repository. Please run this from your project root."
    exit 1
fi

# Get repo info
REPO_ROOT="$(git rev-parse --show-toplevel)"
REPO_NAME="$(basename "$REPO_ROOT")"
WORKTREE_ROOT="$(dirname "$REPO_ROOT")/.worktrees/$REPO_NAME"

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║${NC}        Multi-Agent Development Environment Setup           ${GREEN}║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
info "Repository: $REPO_NAME"
info "Location:   $REPO_ROOT"
info "Worktrees:  $WORKTREE_ROOT"
echo ""

# Check if worktreectl.sh exists
WORKTREECTL="$REPO_ROOT/tools/worktree/worktreectl.sh"
if [[ ! -f "$WORKTREECTL" ]]; then
    error "worktreectl.sh not found at: $WORKTREECTL"
    error "Make sure you're using a repo created from the civics-template."
    exit 1
fi

# Check if code command is available
if ! command -v code &> /dev/null; then
    warn "'code' command not found. You'll need to open VS Code windows manually."
    warn "To install: Open VS Code → Cmd+Shift+P → 'Shell Command: Install code command'"
    OPEN_VSCODE=false
else
    OPEN_VSCODE=true
fi

# Define agents
AGENTS=("claude" "codex" "gemini")

# Create worktrees
echo ""
info "Creating worktrees..."
echo ""

CREATED_PATHS=()

for agent in "${AGENTS[@]}"; do
    WORKTREE_PATH="$WORKTREE_ROOT/worktree_${agent}-task"
    
    if [[ -d "$WORKTREE_PATH" ]]; then
        warn "Worktree already exists: ${agent}-task (skipping)"
        CREATED_PATHS+=("$WORKTREE_PATH")
    else
        info "Creating worktree for $agent..."
        "$WORKTREECTL" create "${agent}-task" --from main 2>&1 | grep -E "^(Info:|Preparing|HEAD)" | sed 's/^/    /'
        success "Created: ${agent}-task → agent/${agent}-task"
        CREATED_PATHS+=("$WORKTREE_PATH")
    fi
done

# Open VS Code windows
echo ""
if [[ "$OPEN_VSCODE" == true ]]; then
    info "Opening VS Code windows..."
    echo ""
    
    for i in "${!AGENTS[@]}"; do
        agent="${AGENTS[$i]}"
        path="${CREATED_PATHS[$i]}"
        
        if [[ -d "$path" ]]; then
            code -n "$path"
            success "Opened: $agent → $(basename "$path")"
            # Small delay to let VS Code windows open in order
            sleep 0.5
        fi
    done
else
    echo ""
    warn "Open these folders manually in separate VS Code windows:"
    for i in "${!AGENTS[@]}"; do
        echo "    ${AGENTS[$i]}: ${CREATED_PATHS[$i]}"
    done
fi

# Print summary
echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║${NC}                     Setup Complete!                        ${GREEN}║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "  You now have 3 VS Code windows ready:"
echo ""
echo "  ┌─────────────┬─────────────────────┬─────────────┐"
echo "  │   Window    │       Branch        │  CLI to run │"
echo "  ├─────────────┼─────────────────────┼─────────────┤"
echo "  │   Claude    │  agent/claude-task  │   claude    │"
echo "  │   Codex     │  agent/codex-task   │   codex     │"
echo "  │   Gemini    │  agent/gemini-task  │   gemini    │"
echo "  └─────────────┴─────────────────────┴─────────────┘"
echo ""
echo "  Next steps:"
echo "    1. In each VS Code window, open the integrated terminal"
echo "    2. Run the corresponding CLI command (claude, codex, or gemini)"
echo "    3. Give each agent their task (reference your dev_plan.md)"
echo ""
echo "  When done, clean up with:"
echo "    ./tools/worktree/worktreectl.sh remove claude-task --delete-branch"
echo "    ./tools/worktree/worktreectl.sh remove codex-task --delete-branch"
echo "    ./tools/worktree/worktreectl.sh remove gemini-task --delete-branch"
echo ""
