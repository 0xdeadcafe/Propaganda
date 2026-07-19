# propaganda

An LLM agent skill for detecting and analyzing propaganda, influence operations, and narrative manipulation. Works with **Claude Code**, **OpenAI Codex**, and **ChatGPT**.

## What it does

Applies structured cognitive analysis (Bloom's Taxonomy + intelligence tradecraft) to media content to:

- Separate claims from inferences from judgments
- Identify manipulation techniques (anchoring, firehose, emotional hijack, false binary, etc.)
- Surface omissions, source motives, and framing devices
- Produce actionable assessments with confidence levels and update triggers

## Output Modes

| Mode | Input | Output |
|------|-------|--------|
| **FLASH** | < 150 words (tweets, headlines) | ~50-100 words |
| **STANDARD** | 150-3000 words (articles, speeches) | ~500-1500 words |
| **DEEP** | > 3000 words (investigations, IO campaigns) | ~1500-3000 words |

---

## Installation

### One-liner (auto-detect framework)

```bash
git clone https://github.com/0xdeadcafe/Propaganda.git /tmp/propaganda && /tmp/propaganda/install.sh
```

### Install for a specific framework

```bash
git clone https://github.com/0xdeadcafe/Propaganda.git /tmp/propaganda
/tmp/propaganda/install.sh claude      # Claude Code
/tmp/propaganda/install.sh codex       # OpenAI Codex
/tmp/propaganda/install.sh chatgpt     # ChatGPT (copies system prompt)
/tmp/propaganda/install.sh all         # All frameworks
```

### Install into a specific project

```bash
./install.sh claude --project-dir ~/my-project
./install.sh codex --project-dir ~/my-project
```

---

## Framework Details

### Claude Code

Installs to `.claude/skills/propaganda/` in your project and adds a reference to `CLAUDE.md`.

Claude Code reads `CLAUDE.md` at project root for instructions. The installer either creates or appends to it.

```bash
# Manual alternative: just add to your project root
cp CLAUDE.md ~/my-project/CLAUDE.md
cp SKILL.md ~/my-project/SKILL.md
```

### OpenAI Codex

Installs to `.codex/skills/propaganda/` in your project and adds a reference to `AGENTS.md`.

Codex reads `AGENTS.md` at project root for agent instructions. The installer either creates or appends to it.

```bash
# Manual alternative
cp AGENTS.md ~/my-project/AGENTS.md
cp SKILL.md ~/my-project/SKILL.md
```

### ChatGPT

ChatGPT doesn't support file-based skills. The installer copies the system prompt to `.chatgpt/propaganda-system-prompt.md` for you to paste into:

- **Custom GPT**: Paste into the Instructions field
- **ChatGPT Projects**: Paste as project instructions
- **API**: Use as the system message

---

## Repo Structure

```
propaganda/
├── SKILL.md          # Complete skill definition (framework-agnostic)
├── CLAUDE.md         # Claude Code activation instructions
├── AGENTS.md         # OpenAI Codex activation instructions
├── install.sh        # Universal installer
├── README.md
└── LICENSE           # MIT
```

## How it works across frameworks

The core skill lives in `SKILL.md` — a structured prompt that any LLM can follow. The framework-specific files (`CLAUDE.md`, `AGENTS.md`) are thin wrappers that tell the agent to read and follow `SKILL.md` when propaganda analysis is requested.

This means:
- **Any framework** that supports system prompts can use `SKILL.md` directly
- **Claude Code** auto-loads `CLAUDE.md` → references `SKILL.md`
- **Codex** auto-loads `AGENTS.md` → references `SKILL.md`
- **ChatGPT** uses `SKILL.md` content as custom instructions

## Design Principles

- **Read-only** — analyzes structure, never writes files or executes commands
- **No political priors** — applies equally to all sources regardless of alignment
- **Not a fact-checker** — deconstructs narrative structure, doesn't verify claims externally
- **Proportional** — extraordinary claims get extraordinary skepticism, mundane claims get benefit of doubt

## License

MIT
