# Gemini CLI Instructions

You are an AI coding agent (Gemini CLI) working in this repository.

## Multi-Agent Environment

**IMPORTANT**: This repo supports multiple AI agents working simultaneously. Before starting work:

1. Check if other agents are active (ask the user or check `git worktree list`)
2. If so, create your own worktree:
   ```bash
   ./tools/worktree/worktreectl.sh create <your-task-name>
   ```
3. Ask the user to open your worktree in a **separate VS Code window**:
   ```bash
   code ../.worktrees/<repo>/worktree_<your-task-name>
   ```

## Your Worktree

- **Your branch**: `agent/<your-task-name>` (created automatically)
- **Your path**: `../.worktrees/<repo>/worktree_<your-task-name>/`
- **Stay in your directory**: Never `cd` to another agent's worktree
- **Avoid `git checkout`**: Your branch is already checked out in your worktree

## Worktree Commands

| Command | Description |
|---------|-------------|
| `./tools/worktree/worktreectl.sh create <name>` | Create new worktree |
| `./tools/worktree/worktreectl.sh list` | List all worktrees |
| `./tools/worktree/worktreectl.sh remove <name>` | Remove worktree |
| `./tools/worktree/worktreectl.sh help` | Show all options |

## Git Workflow

Commit and push normally from your worktree:
```bash
git add .
git commit -m "Your message"
git push -u origin agent/<your-task-name>
```

When ready for review, create a PR to `main`.

## Cleanup

When your task is complete:
```bash
./tools/worktree/worktreectl.sh remove <your-task-name> --delete-branch
```

---

<!-- PROJECT-SPECIFIC INSTRUCTIONS BELOW -->
<!-- Add your project's build commands, coding standards, and architecture notes here -->

## Project Setup

<!-- Example:
```bash
npm install
npm run dev
```
-->

## Coding Standards

<!-- Example:
- Use TypeScript strict mode
- Prefer functional components
- Run `npm run lint` before committing
-->

## Architecture

<!-- Example:
- src/components/ - React components
- src/lib/ - Utility functions
- src/api/ - API routes
-->
