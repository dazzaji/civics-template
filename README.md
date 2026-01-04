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
