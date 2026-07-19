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

```bash
git clone https://github.com/0xdeadcafe/Propaganda.git
```

### Claude Code

Add to your project's `CLAUDE.md`:

```
Read and follow SKILL.md from the propaganda skill for propaganda/narrative analysis.
```

Or symlink/copy `SKILL.md` into your project.

### OpenAI Codex

Add to your project's `AGENTS.md`:

```
Read and follow SKILL.md from the propaganda skill for propaganda/narrative analysis.
```

Or symlink/copy `SKILL.md` into your project.

### ChatGPT

Paste the contents of `SKILL.md` into:
- **Custom GPT**: Instructions field
- **ChatGPT Projects**: Project instructions
- **API**: System message

---

## How it works

The core skill lives in `SKILL.md` — a structured prompt that any LLM can follow. Point your framework's instruction mechanism at it and provide source text as user input.

## Design Principles

- **Read-only** — analyzes structure, never writes files or executes commands
- **No political priors** — applies equally to all sources regardless of alignment
- **Not a fact-checker** — deconstructs narrative structure, doesn't verify claims externally
- **Proportional** — extraordinary claims get extraordinary skepticism, mundane claims get benefit of doubt

## Credits

Inspired by [@schwalm5132](https://github.com/schwalm5132)

## License

MIT
