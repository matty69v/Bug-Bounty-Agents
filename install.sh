#!/usr/bin/env bash
# Bug-Bounty-Agents installer
# Auto-detects supported LLM clients and installs agent prompts in the right place.
#
# Usage:
#   ./install.sh                # interactive: detect + ask
#   ./install.sh --target claude         # force claude code (global)
#   ./install.sh --target claude-local   # claude code, current project
#   ./install.sh --target copilot        # github copilot chat (vs code)
#   ./install.sh --target cursor         # cursor (current project)
#   ./install.sh --target all            # install everywhere detected
#   ./install.sh --dry-run               # show what would happen
#   ./install.sh --uninstall --target X  # remove agents from target

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=0
UNINSTALL=0
TARGET=""

# ---- helpers ----------------------------------------------------------------

c_reset=$'\033[0m'
c_bold=$'\033[1m'
c_dim=$'\033[2m'
c_red=$'\033[31m'
c_green=$'\033[32m'
c_yellow=$'\033[33m'
c_blue=$'\033[34m'

log()  { printf '%s\n' "$*"; }
info() { printf '%b\n' "${c_blue}info${c_reset}  $*"; }
ok()   { printf '%b\n' "${c_green}ok${c_reset}    $*"; }
warn() { printf '%b\n' "${c_yellow}warn${c_reset}  $*"; }
err()  { printf '%b\n' "${c_red}error${c_reset} $*" >&2; }

run() {
  if [[ $DRY_RUN -eq 1 ]]; then
    printf '%b%s%b\n' "${c_dim}" "[dry-run] $*" "${c_reset}"
  else
    eval "$@"
  fi
}

usage() {
  sed -n '2,15p' "$0" | sed 's/^# \{0,1\}//'
  exit 0
}

# ---- arg parsing ------------------------------------------------------------

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)    TARGET="${2:-}"; shift 2 ;;
    --dry-run)   DRY_RUN=1; shift ;;
    --uninstall) UNINSTALL=1; shift ;;
    -h|--help)   usage ;;
    *) err "unknown arg: $1"; usage ;;
  esac
done

# ---- platform paths ---------------------------------------------------------

os="$(uname -s)"
case "$os" in
  Darwin) COPILOT_PROMPTS="$HOME/Library/Application Support/Code/User/prompts" ;;
  Linux)  COPILOT_PROMPTS="$HOME/.config/Code/User/prompts" ;;
  *)      COPILOT_PROMPTS="$HOME/.config/Code/User/prompts" ;;
esac

CLAUDE_GLOBAL="$HOME/.claude/agents"
CLAUDE_LOCAL=".claude/agents"
CURSOR_LOCAL=".cursor/rules"

# ---- detection --------------------------------------------------------------

detect() {
  local found=()
  command -v claude  >/dev/null 2>&1 && found+=("claude")
  command -v code    >/dev/null 2>&1 && found+=("copilot")
  command -v cursor  >/dev/null 2>&1 && found+=("cursor")
  printf '%s\n' "${found[@]:-}"
}

# ---- install / uninstall actions -------------------------------------------

agent_files() {
  # All top-level agent .md files except README/AGENTS/CHANGELOG/etc.
  find "$SCRIPT_DIR" -maxdepth 1 -type f -name '*.md' \
    ! -name 'README.md' \
    ! -name 'AGENTS.md' \
    ! -name 'CHANGELOG.md' \
    ! -name 'CONTRIBUTING.md' \
    ! -name 'SECURITY.md'
}

install_to_dir() {
  local dest="$1" suffix="${2:-}"
  run "mkdir -p \"$dest\""
  local count=0
  while IFS= read -r f; do
    local base; base="$(basename "$f")"
    local out="$dest/${base%.md}${suffix}"
    run "cp \"$f\" \"$out\""
    count=$((count + 1))
  done < <(agent_files)
  ok "installed $count agents → $dest"
}

uninstall_from_dir() {
  local dest="$1" suffix="${2:-}"
  if [[ ! -d "$dest" ]]; then warn "nothing to uninstall at $dest"; return; fi
  local count=0
  while IFS= read -r f; do
    local base; base="$(basename "$f")"
    local out="$dest/${base%.md}${suffix}"
    if [[ -f "$out" ]]; then run "rm \"$out\""; count=$((count + 1)); fi
  done < <(agent_files)
  ok "removed $count agents from $dest"
}

apply() {
  local target="$1"
  local action="install"; [[ $UNINSTALL -eq 1 ]] && action="uninstall"
  case "$target" in
    claude)
      info "$action: Claude Code (global) → $CLAUDE_GLOBAL"
      [[ $UNINSTALL -eq 1 ]] && uninstall_from_dir "$CLAUDE_GLOBAL" ".md" \
                             || install_to_dir   "$CLAUDE_GLOBAL" ".md"
      ;;
    claude-local)
      info "$action: Claude Code (project) → $CLAUDE_LOCAL"
      [[ $UNINSTALL -eq 1 ]] && uninstall_from_dir "$CLAUDE_LOCAL" ".md" \
                             || install_to_dir   "$CLAUDE_LOCAL" ".md"
      ;;
    copilot)
      info "$action: GitHub Copilot Chat → $COPILOT_PROMPTS"
      [[ $UNINSTALL -eq 1 ]] && uninstall_from_dir "$COPILOT_PROMPTS" ".chatmode.md" \
                             || install_to_dir   "$COPILOT_PROMPTS" ".chatmode.md"
      ;;
    cursor)
      info "$action: Cursor (project) → $CURSOR_LOCAL"
      [[ $UNINSTALL -eq 1 ]] && uninstall_from_dir "$CURSOR_LOCAL" ".md" \
                             || install_to_dir   "$CURSOR_LOCAL" ".md"
      ;;
    *) err "unknown target: $target"; exit 1 ;;
  esac
}

# ---- main -------------------------------------------------------------------

log "${c_bold}Bug-Bounty-Agents installer${c_reset}"
log ""

if [[ -n "$TARGET" ]]; then
  if [[ "$TARGET" == "all" ]]; then
    mapfile -t found < <(detect)
    [[ ${#found[@]} -eq 0 ]] && { err "no supported clients detected"; exit 1; }
    for t in "${found[@]}"; do apply "$t"; done
  else
    apply "$TARGET"
  fi
  exit 0
fi

# interactive
mapfile -t found < <(detect)
if [[ ${#found[@]} -eq 0 ]]; then
  warn "no clients auto-detected (claude, code, cursor not in PATH)"
  log "Pick a target manually:"
  log "  ./install.sh --target claude         (Claude Code global)"
  log "  ./install.sh --target claude-local   (Claude Code project)"
  log "  ./install.sh --target copilot        (Copilot Chat)"
  log "  ./install.sh --target cursor         (Cursor project)"
  exit 1
fi

info "detected clients: ${found[*]}"
read -r -p "Install for all detected clients? [Y/n] " ans
ans="${ans:-Y}"
if [[ "$ans" =~ ^[Yy]$ ]]; then
  for t in "${found[@]}"; do apply "$t"; done
else
  log "Aborted. Re-run with --target <name>."
fi
