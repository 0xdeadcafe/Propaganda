# propaganda

An LLM agent skill for detecting and analyzing propaganda, influence operations, and narrative manipulation.

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

## Usage

### With pi
```bash
cat article.txt | pi -p /skill:propaganda
curl -s "https://example.com/article" | w3m -dump -T text/html | pi -p /skill:propaganda
```

### Framework-agnostic

The skill is defined in `SKILL.md` as a structured prompt. It can be used with any LLM agent framework that supports system/skill prompts:

1. Feed the contents of `SKILL.md` as a system prompt or skill instruction
2. Provide the source text (article, post, etc.) as user input
3. The LLM will produce structured analysis following the framework

## Installation

### pi (symlink into skills directory)
```bash
ln -s /path/to/propaganda ~/.pi/agent/skills/propaganda
```

### Other frameworks
Copy or reference `SKILL.md` according to your framework's skill/prompt loading mechanism.

## Design Principles

- **Read-only** — analyzes structure, never writes files or executes commands
- **No political priors** — applies equally to all sources regardless of alignment
- **Not a fact-checker** — deconstructs narrative structure, doesn't verify claims externally
- **Proportional** — extraordinary claims get extraordinary skepticism, mundane claims get benefit of doubt

## License

MIT
