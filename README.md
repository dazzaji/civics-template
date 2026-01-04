# Project Name

<!-- Replace with your project description -->

## Getting Started

<!-- Add your project-specific setup instructions here -->

## Multi-Agent Development

This repo is configured for parallel AI agent development. Each AI CLI reads its own instruction file:

| CLI | Instruction File |
|-----|------------------|
| Claude Code | [CLAUDE.md](CLAUDE.md) |
| OpenAI Codex | [AGENTS.md](AGENTS.md) |
| Gemini CLI | [GEMINI.md](GEMINI.md) |

**Quick start for agents:**
```bash
./tools/worktree/worktreectl.sh create <agent-name>
code ../.worktrees/<repo>/worktree_<agent-name>
```

## Project Structure

```
.
├── AGENTS.md           # Codex instructions (also generic agents)
├── CLAUDE.md           # Claude Code instructions
├── GEMINI.md           # Gemini CLI instructions
├── README.md           # This file
└── tools/
    └── worktree/       # Git worktree management scripts
        ├── worktreectl.sh
        ├── create_worktree.sh
        └── README.md
```

## License

<!-- Add your license here -->

---

# Step-by-Step User Guide

How to run multiple AI coding agents (Claude Code, Codex, Gemini CLI) in parallel on the same project.

## Phase 1: Create a Repo from This Template

1. Go to your template repo on GitHub (e.g., `https://github.com/YOUR_USERNAME/civics-template`)
2. Click **"Use this template"** → **"Create a new repository"**
3. Name your new repo (e.g., `widget-frontend`)
4. Select **Private** or **Public**
5. Click **"Create repository"**

## Phase 2: Clone and Add Your Project Code

1. **Clone with GitHub Desktop:**
   - Open GitHub Desktop
   - File → Clone Repository
   - Select your new repo
   - Clone to your preferred location (e.g., `~/Documents/GitHub/widget-frontend`)

2. **Add your project code to `main`:**
   - Copy your existing project files into the repo
   - Create a `dev_plan.md` with implementation details for the agents
   - Commit and push to `main`

## Phase 3: Create Worktrees (One per Agent)

Open Terminal in your repo directory and run:

```bash
cd ~/Documents/GitHub/widget-frontend

# Create worktree for Claude Code
./tools/worktree/worktreectl.sh create claude-task

# Create worktree for Codex
./tools/worktree/worktreectl.sh create codex-task

# Create worktree for Gemini
./tools/worktree/worktreectl.sh create gemini-task
```

This creates:
```
../.worktrees/widget-frontend/
    worktree_claude-task/   (branch: agent/claude-task)
    worktree_codex-task/    (branch: agent/codex-task)
    worktree_gemini-task/   (branch: agent/gemini-task)
```

## Phase 4: Open Separate VS Code Windows

Run these commands to open each worktree in its own VS Code window:

```bash
# Window 1 - Claude Code
code ~/Documents/GitHub/.worktrees/widget-frontend/worktree_claude-task

# Window 2 - Codex
code ~/Documents/GitHub/.worktrees/widget-frontend/worktree_codex-task

# Window 3 - Gemini
code ~/Documents/GitHub/.worktrees/widget-frontend/worktree_gemini-task
```

You now have **3 separate VS Code windows**, each on its own branch.

## Phase 5: Start Each AI CLI

In each VS Code window, open the integrated terminal and start the CLI:

| Window | CLI | Command |
|--------|-----|---------|
| 1 | Claude Code | `claude` |
| 2 | Codex | `codex` |
| 3 | Gemini | `gemini` |

Each CLI automatically reads its instruction file (`CLAUDE.md`, `AGENTS.md`, or `GEMINI.md`).

## Phase 6: Assign Tasks

Give each agent a task that references your `dev_plan.md`:

**Claude Code (Window 1):**
```
Read dev_plan.md and implement the header component as described in section 1.
```

**Codex (Window 2):**
```
Read dev_plan.md and implement the sidebar component as described in section 2.
```

**Gemini (Window 3):**
```
Read dev_plan.md and implement the footer component as described in section 3.
```

## Phase 7: Review and Merge

When agents complete their work:

1. Each agent commits and pushes to their branch (`agent/claude-task`, etc.)
2. Go to GitHub and create PRs from each agent branch to `main`
3. Review each PR
4. Merge the ones you approve

## Phase 8: Cleanup

When done with all agents:

```bash
cd ~/Documents/GitHub/widget-frontend

./tools/worktree/worktreectl.sh remove claude-task --delete-branch
./tools/worktree/worktreectl.sh remove codex-task --delete-branch
./tools/worktree/worktreectl.sh remove gemini-task --delete-branch
```

## Quick Reference

| Step | Action |
|------|--------|
| Create repo | GitHub → Use template → Create |
| Clone | GitHub Desktop → Clone |
| Add code | Copy files, create `dev_plan.md`, commit to `main` |
| Create worktrees | `./tools/worktree/worktreectl.sh create <name>` × 3 |
| Open windows | `code ../.worktrees/<repo>/worktree_<name>` × 3 |
| Start CLIs | `claude`, `codex`, `gemini` in each window |
| Assign tasks | Reference `dev_plan.md` sections |
| Review | PRs from agent branches to `main` |
| Cleanup | `./tools/worktree/worktreectl.sh remove <name> --delete-branch` |
