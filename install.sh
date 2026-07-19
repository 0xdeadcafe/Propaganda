#!/usr/bin/env bash
# propaganda skill installer
# Install via: curl -fsSL <raw-git-url>/install.sh | bash
# Or clone and run: git clone <repo-url> && cd propaganda && ./install.sh [target]
#
# Targets: claude, codex, chatgpt, all
# If no target specified, installs for all detected frameworks.

set -euo pipefail

REPO_URL="${PROPAGANDA_REPO_URL:-https://github.com/user/propaganda.git}"
SKILL_DIR=""
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# If running from within the repo, use local files
if [[ -f "$SCRIPT_DIR/SKILL.md" ]]; then
    SKILL_DIR="$SCRIPT_DIR"
else
    # Clone to temp and use that
    SKILL_DIR="$(mktemp -d)/propaganda"
    echo "Cloning propaganda skill..."
    git clone --depth 1 "$REPO_URL" "$SKILL_DIR"
fi

usage() {
    cat <<EOF
Usage: ./install.sh [target...]

Targets:
  claude    Install for Claude Code (copies CLAUDE.md + SKILL.md to project)
  codex     Install for OpenAI Codex (copies AGENTS.md + SKILL.md to project)
  chatgpt   Print system prompt for ChatGPT custom instructions
  all       Install for all frameworks

Options:
  --project-dir DIR   Target project directory (default: current directory)
  --help              Show this help

Examples:
  ./install.sh claude --project-dir ~/app  # Add to a Claude Code project
  ./install.sh codex                       # Add to current project for Codex
  ./install.sh all                         # Install everywhere possible
  
Git URL install:
  git clone <repo-url> /tmp/propaganda && /tmp/propaganda/install.sh claude
EOF
    exit 0
}

PROJECT_DIR="$(pwd)"
TARGETS=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        --project-dir)
            PROJECT_DIR="$2"
            shift 2
            ;;
        --help|-h)
            usage
            ;;
        *)
            TARGETS+=("$1")
            shift
            ;;
    esac
done

# If no targets specified, detect what's available
if [[ ${#TARGETS[@]} -eq 0 ]]; then
    echo "No target specified. Detecting frameworks..."
    
    # Check for claude
    if command -v claude &>/dev/null || [[ -f "$PROJECT_DIR/CLAUDE.md" ]]; then
        TARGETS+=(claude)
    fi
    
    # Check for codex
    if command -v codex &>/dev/null || [[ -f "$PROJECT_DIR/AGENTS.md" ]]; then
        TARGETS+=(codex)
    fi
    
    if [[ ${#TARGETS[@]} -eq 0 ]]; then
        echo "No frameworks detected. Installing for claude (default)."
        TARGETS=(claude)
    fi
fi

install_claude() {
    local dest="$PROJECT_DIR/.claude/skills/propaganda"
    echo "Installing for Claude Code → $dest"
    mkdir -p "$dest"
    cp "$SKILL_DIR/SKILL.md" "$dest/SKILL.md"
    cp "$SKILL_DIR/CLAUDE.md" "$dest/CLAUDE.md"
    
    # Add include to root CLAUDE.md if it exists
    local root_claude="$PROJECT_DIR/CLAUDE.md"
    local include_line="See .claude/skills/propaganda/CLAUDE.md for propaganda analysis skill."
    if [[ -f "$root_claude" ]]; then
        if ! grep -q "propaganda" "$root_claude" 2>/dev/null; then
            echo "" >> "$root_claude"
            echo "$include_line" >> "$root_claude"
            echo "  → Added reference to existing CLAUDE.md"
        fi
    else
        echo "$include_line" > "$root_claude"
        echo "  → Created CLAUDE.md with skill reference"
    fi
    echo "✓ Claude Code skill installed."
}

install_codex() {
    local dest="$PROJECT_DIR/.codex/skills/propaganda"
    echo "Installing for Codex → $dest"
    mkdir -p "$dest"
    cp "$SKILL_DIR/SKILL.md" "$dest/SKILL.md"
    cp "$SKILL_DIR/AGENTS.md" "$dest/AGENTS.md"
    
    # Add include to root AGENTS.md if it exists
    local root_agents="$PROJECT_DIR/AGENTS.md"
    local include_line="See .codex/skills/propaganda/AGENTS.md for propaganda analysis skill."
    if [[ -f "$root_agents" ]]; then
        if ! grep -q "propaganda" "$root_agents" 2>/dev/null; then
            echo "" >> "$root_agents"
            echo "$include_line" >> "$root_agents"
            echo "  → Added reference to existing AGENTS.md"
        fi
    else
        echo "$include_line" > "$root_agents"
        echo "  → Created AGENTS.md with skill reference"
    fi
    echo "✓ Codex skill installed."
}

install_chatgpt() {
    echo "═══════════════════════════════════════════════════════════"
    echo " ChatGPT Installation"
    echo "═══════════════════════════════════════════════════════════"
    echo ""
    echo "ChatGPT doesn't support file-based skill installation."
    echo "Use one of these methods:"
    echo ""
    echo "1. CUSTOM GPT: Copy the contents of SKILL.md into your"
    echo "   custom GPT's instruction field."
    echo ""
    echo "2. PROJECT INSTRUCTIONS: In ChatGPT Projects, paste the"
    echo "   contents of SKILL.md as project instructions."
    echo ""
    echo "3. The skill content is at:"
    echo "   $SKILL_DIR/SKILL.md"
    echo ""
    
    # Also copy to a convenient location
    local dest="$PROJECT_DIR/.chatgpt"
    mkdir -p "$dest"
    cp "$SKILL_DIR/SKILL.md" "$dest/propaganda-system-prompt.md"
    echo "✓ Copied to $dest/propaganda-system-prompt.md"
    echo "  Paste this file's contents into ChatGPT instructions."
}

# Execute installations
for target in "${TARGETS[@]}"; do
    case "$target" in
        claude)  install_claude ;;
        codex)   install_codex ;;
        chatgpt) install_chatgpt ;;
        all)
            install_claude
            install_codex
            install_chatgpt
            ;;
        *)
            echo "Unknown target: $target"
            usage
            ;;
    esac
done

echo ""
echo "Done."
